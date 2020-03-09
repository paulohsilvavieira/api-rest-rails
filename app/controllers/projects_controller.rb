class ProjectsController < ApplicationController
  def index
    @projects = user.projects
    render json: { projects: @projects }, status: :ok
  end

  def create
    @decoded = Jsonwebtoken.decode(header_authorization)
    @project = Project.new(user_params)
    @project.user = @decoded[:user_id]

    if @project.save
      render json: @project, status: :created
    else
      render json: { errors: @project.errors.full_messages },
              status: :unprocessable_entity
    end
  end

  def update
    project = Project.find(params[:id])
    render json: { errors: 'Project not found' }, status: :not_found if user.nil?
    unless project.update(project_params)
      render json: { errors: project.errors.full_messages },
              status: :unprocessable_entity
    end
  end

  def delete
    @project = Project.find(params[:id])
    @decoded = Jsonwebtoken.decode(header_authorization)
    user = User.find(!decoded[:user_id])
    render json: { errors: 'Project not found' }, status: :not_found if @project.nil?
    render status: :forbidden if @project.user != user
    render status: :no_content unless @project.destroy
  end

  def find
    @project=Project.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end

  private

  def project_params
    params.permit(
      :title, :description, :id
    )
  end

  def user
    @decoded = Jsonwebtoken.decode(header_authorization)
    @user = User.find(@decoded[:user_id])
  end

  def header_authorization
    header = request.headers['Authorization']
    header.split(' ').last if header.nil?
  end
end
