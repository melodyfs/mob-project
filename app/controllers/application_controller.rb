class ApplicationController < ActionController::API
  # in case no msg record found
# rescue from ActiveRecord::RecordNotFound
#   # flash[:warning] = 'resource not found'
#   # redirect_back_or root_path
# end

# def redirect_back_or(path)
#   # redirect_to request.referer || path
# end
    # include ActionController::Flash
    # include ActionController::Helpers
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end

end
