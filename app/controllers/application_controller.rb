class ApplicationController < ActionController::API
  # in case no msg record found
rescue from ActiveRecord::RecordNotFound do
  # flash[:warning] = 'resource not found'
  # redirect_back_or root_path
end

def redirect_back_or(path)
  # redirect_to request.referer || path
end

end
