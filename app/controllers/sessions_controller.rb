class SessionsController < ApplicationController
  skip_before_action :authorize

  def new
  end

  def create
    user = User.create_if_empty(params[:name], params[:password])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_url
    else
      redirect_to login_url, alert: 'Invalid username/password combination!'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, notice: 'Logged out'
  end
end
