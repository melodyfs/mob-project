# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
    include ActionController::Helpers
    include ActionController::Flash
    before_action :configure_permitted_parameters, only: [:create]
    skip_before_action :verify_signed_out_user, only: [:destroy]

  # def create
    # custom sign-in code
  # end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  prepend_before_filter :require_no_authentication, :only => [:create ]
  include Devise::Controllers::InternalHelpers

  before_filter :ensure_params_exist

  respond_to :json

  def create
    build_resource
    resource = User.find_for_database_authentication(:login=>params[:user_login][:login])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user_login][:password])
      sign_in("user", resource)
      render :json=> {:success=>true, :auth_token=>resource.authentication_token, :login=>resource.login, :email=>resource.email}
      return
    end
    invalid_login_attempt
  end

  def destroy
    sign_out(resource_name)
  end

  protected
  def ensure_params_exist
    return unless params[:user_login].blank?
    render :json=>{:success=>false, :message=>"missing user_login parameter"}, :status=>422
  end

  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  end


  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
