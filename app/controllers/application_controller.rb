class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def encode_token(payload)
    JWT.encode(payload, ENV['SECRET_KEY_BASE'])
  end
  
  def decode_token
    auth_header = request.headers['Authorization']
    if auth_header
      token = auth_header.split(' ')[0]
      begin
        JWT.decode(token, ENV['SECRET_KEY_BASE'], true, algorithm: 'HS256')
      rescue => exceptions
        nil
      end
    end
  end

  def logged_in_user
    token = decode_token
    if token
      user_id = token[0]['user_id']
      @current_user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
