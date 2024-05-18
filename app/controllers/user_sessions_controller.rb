class UserSessionsController < ApplicationController
  def create
    user = login(params[:email], params[:password])
    if user
      token = encode_token({ user_id: user.id })
      render json: { message: 'Login successful', token: token }
    else
      render json: { message: 'Login failed', error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    logout
    render json: { message: 'Logged out' }, status: :ok
  end

end
