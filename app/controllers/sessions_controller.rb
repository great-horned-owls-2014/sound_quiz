class SessionsController < ApplicationController

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url, notice: "logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render :new
    end
  end

  def new
    @user = User.new
  end

end
