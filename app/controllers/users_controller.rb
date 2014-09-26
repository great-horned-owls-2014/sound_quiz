class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.permit(:email, :password))
    if @user.save
      redirect_to root_url, notice: "You signed up!"
    else
      redirect_to new_user_path,  notice: "You failed to sign up!"
    end
  end
end
