require 'bcrypt'

class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "logged in!"
    else
      # flash.now.alert = "Invalid email or password"
      redirect_to root_url, notice: "Invalid email or password"
    end
  end

  def new
  end

  def logout
    session.clear
    redirect_to root_url, notice: "Logged out!"
  end

end
