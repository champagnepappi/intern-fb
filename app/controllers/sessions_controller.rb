class SessionsController < ApplicationController
  def new
    console
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) 
      log_in user
      redirect_to user
      flash[:success] = "Welcome #{user.full_name}"
    else
      flash.now[:alert] = "Invalid email and password combination"
      render 'new'
      console
    end
  end
  def destroy
    log_out
    redirect_to login_url
    flash[:success] = "Successfully logged out!"
  end
end