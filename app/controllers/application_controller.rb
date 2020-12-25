class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authorize

  protected

    def authorize
      unless authorize_non_html or User.find_by(id: session[:user_id])
        redirect_to login_url, notice: 'Please log in.'
      end   
    end

  private

    def authorize_non_html
      if request.format == Mime::HTML
        return false
      end
      authenticate_or_request_with_http_basic('Application') do |name, password|
        return name == 'dave' && password == 'secret'
      end
    end
end
