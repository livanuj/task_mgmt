class UsersController < ApplicationController

  def new
    redirect_to root_path if current_user.present?

    @user = User.new
  end

  def create
    user = User.new(user_params)

    if params[:user][:password] == params[:user][:password_confirmation]
      if user.save
        redirect_to root_path, notice: "User created successfully"
      else
        redirect_to root_path, notice: "Couldn't create User"
      end
    else
      redirect_to root_path, notice: "password doesn't match"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
