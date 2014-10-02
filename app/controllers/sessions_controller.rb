require 'bcrypt'

class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url
    else
      # flash.now.alert = "Invalid email or password"
      redirect_to login_path, notice: "Invalid email or password"
    end
  end

  def new
  end

  def logout
    session.clear
    redirect_to root_url
  end

end
