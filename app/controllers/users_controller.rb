class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params.permit(:email, :password, :username))
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "You signed up!"
    else
      redirect_to new_user_path,  notice: "Something went wrong!"
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(username: params[:user][:username], email: params[:user][:email])
    if params[:user][:oldpassword] != ""
      old_password = BCrypt::Password.new(@user.password_digest)
      if old_password == params[:user][:oldpassword] && params[:user][:newpassword] == params[:user][:confirmpassword]
        @user.update(password: params[:user][:newpassword])
        notice_string = "Edit succesful!"
      else
        notice_string =  "Something went wrong with your edit!"
      end
    else
       notice_string = "Edit succesful!"
    end
    redirect_to root_url, notice: notice_string
  end

  def show
    @user = User.find(params[:id])
    @artist_taken = Hash.new(0)
    @user.taken_quizzes.each { |takenquiz| @artist_taken[takenquiz.artist.id] += 1}
    @artist_taken = @artist_taken.sort_by {|id, count| count}.reverse
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    session.clear
    redirect_to root_url, notice: "User was deleted successfully!"
  end
end

