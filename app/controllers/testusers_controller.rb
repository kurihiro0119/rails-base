class TestusersController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    testusers = TestUser.all

    response = testusers.map do |testuser|
      {
        id: testuser.id,
        userid: testuser.user_id,
        title: testuser.title,
        body: testuser.body
      }
    end

    render json: response
  end

  def show
    id = (params[:id]).to_i
    testuser = TestUser.find_by(id: id)
    if testuser.nil?
      render json: { message: 'TestUser not found' }
      return
    end

    response = {
      id: testuser.id,
      userid: testuser.user_id,
      title: testuser.title,
      body: testuser.body
    }

    render json: response
  end

  def new
    testuser = TestUser.new(test_user_params)
    testuser.user_id = SecureRandom.uuid

    if testuser.save
      render json: { message: 'TestUser created successfully' }, status: :created
    else
      render json: { message: 'TestUser creation failed' }, status: :unprocessable_entity
    end
  end

  private
  def test_user_params
    params.permit(:title, :body)
  end
end
