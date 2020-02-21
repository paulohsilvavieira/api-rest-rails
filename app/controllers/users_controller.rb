class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index update destroy]

  # GET /users
  def index
    @users = User.all
    render json: { users: @users }, status: :ok
  end

  # GET /users/{username}
  def show
    find_user
    render json: @user, status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
              status: :unprocessable_entity
    end
  end

  def update
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    @decoded = Jsonwebtoken.decode(header)
    params[:id] = @decoded[:user_id]
    user = User.find(params[:id])
    render json: { errors: 'User not found' }, status: :not_found if user.nil?
    unless user.update(user_params)
      render json: { errors: user.errors.full_messages },
              status: :unprocessable_entity
    end
  end

  def destroy
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    @decoded = Jsonwebtoken.decode(header)
    params[:id] = @decoded[:user_id]
    user = User.find(params[:id])
    render json: { errors: 'User not found' }, status: :not_found if user.nil?
    render  status: :no_content unless user.destroy
  end

  private

  def find_user
    @user = User.find_by_username!(params[:username])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(
      :name, :username, :email, :password, :password_confirmation, :id
    )
  end
end
