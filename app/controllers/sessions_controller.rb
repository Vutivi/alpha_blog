class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success]   = "You have been succesfully logged in."
      redirect_to articles_path
    else
      flash.now[:danger] = "Wrong username/password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success]   = "You have been succesfully logged out."
    redirect_to root_path
  end
end
