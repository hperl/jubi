class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  # Protect the staging environment with basic authentication
  if Settings.basic_auth
    http_basic_authenticate_with name: Settings.basic_auth.name,
                                 password: Settings.basic_auth.password
  end

  rescue_from CanCan::AccessDenied do |exception|
    render file: "#{Rails.root}/public/403",
           formats: [:html], status: 403, layout: false
  end

  before_action do
    resource = controller_name.singularize.to_sym
    params[resource] &&= filtered_params if respond_to?(:filtered_params, true)
  end


  def after_sign_in_path_for(resource)
    profile_path
  end

  def render_404
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

  def create_invitations(email_addresses)
    email_addresses.split("\r\n").each do |email|
      Invitation.create(email: email, group_id: @group.id)
    end
  end

  def load_user
    authenticate_user!
    @user = current_user
  end

  private
  def set_locale
    header_locale = request.headers['X-Locale']
    params_locale = -> { params[:locale] if I18n.available_locales.include? params[:locale].try(:to_sym) }
    I18n.locale = header_locale ||
      params_locale.call ||
      http_accept_language.compatible_language_from(I18n.available_locales) ||
      I18n.default_locale
  end
end
