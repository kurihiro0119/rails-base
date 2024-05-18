class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { message: 'User created', user: @user }, status: :created
    else
      render json: { message: 'User not created', error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
