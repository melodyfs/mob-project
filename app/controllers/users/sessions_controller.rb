# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
    include ActionController::Helpers
    include ActionController::Flash
    before_action :configure_permitted_parameters, only: [:create]

  # def create
    # custom sign-in code
  # end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
