require 'net/https'

# force ruby to use shipped ssl certs
module Net
  class HTTP
    alias_method :original_use_ssl=, :use_ssl=
    
    def use_ssl=(flag)
      self.ca_file = File.join(Rails.root, 'lib', 'ca-bundle.crt')
      #self.ca_file = File.join(Rails.root, 'lib', 'intranet.yfu.de.crt')
      self.verify_mode = OpenSSL::SSL::VERIFY_PEER
      self.original_use_ssl = flag
    end
  end
end

