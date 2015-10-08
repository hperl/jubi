require 'net/http'
require 'open-uri'
require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class PassingDatabaseAuthenticatable < Authenticatable
      def authenticate!
        resource  = valid_password? && mapping.to.find_for_database_authentication(authentication_hash)
        encrypted = false

        if validate(resource){ encrypted = true; resource.valid_password?(password) }
          resource.after_database_authentication
          success!(resource)
        end
      end
    end

    class IntranetAuthenticatable < Authenticatable
      def valid?
        return false if !super
        # valid iff the user is either new or marked as intranet user
        @resource = mapping.to.find_for_database_authentication(authentication_hash)
        !@resource || @resource.intranet_user
      end

      def authenticate!
        # check if we can login into the intranet with username and password
        email    = params[:user][:email]
        password = params[:user][:password]
        uri = URI('https://intranet.yfu.de/benutzer/anmelden')
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        req = Net::HTTP::Post.new(uri.request_uri)
        req.form_data = { "user[username]" => email,
                          "user[password]" => password,
                          "commit" => "Login" }
        res = http.request(req)
        # Intranet sends a 302 on success
        if res.code == '302'
          # create a new user if one does not exist, mark new user as confirmed
          if @resource
            # user resource exists, set password
            @resource.password = password
            @resource.save!
          else
            # user does not exist yet, create and mark as confirmed
            @resource = mapping.to.new(email: email, password: password, intranet_user: true)
            @resource.skip_confirmation!
            @resource.save!
          end
          success!(@resource)
        else
          fail(:not_found_in_database)
        end
      end
    end
  end
end


Warden::Strategies.add(:intranet_authenticatable, Devise::Strategies::IntranetAuthenticatable)
Warden::Strategies.add(:passing_database_authenticatable, Devise::Strategies::PassingDatabaseAuthenticatable)
