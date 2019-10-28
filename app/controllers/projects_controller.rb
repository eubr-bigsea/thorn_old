class ProjectsController < ApplicationController
  load_and_authorize_resource
  before_action :set_project, only: %i[show update destroy add_manager remove_manager]

  def index
    @projects = if current_user.is_admin?
                  Project.all
                else
                  current_user.projects
                end

    paginate @projects, ProjectSerializer
  end

  def show
    render json: ProjectSerializer.new(@project)
  end

  def create
    @project = Project.create!(project_params)

    managers_ids&.each do |manager_id|
      manager = User.find_by(id: manager_id)
      manager&.add_role :manager, @project
    end

    render json: ProjectSerializer.new(@project)
  end

  def update
    @project.update!(project_params)
    @project.roles.destroy_all

    managers_ids&.each do |manager_id|
      manager = User.find_by(id: manager_id)
      manager&.add_role :manager, @project
    end

    render json: ProjectSerializer.new(@project)
  end

  def destroy
    @project.destroy
  end

  def add_manager
    @user = User.find(user_params)
    @user.add_role :manager, @project

    render json: UserSerializer.new(@user), status: :created
  end

  def remove_manager
    @user = User.find(user_params)
    @user.remove_role :manager, @project
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, :category, :subcategory)
  end

  def managers_ids
    params.require(:project).permit(managers_ids: [])[:managers_ids]
  end
end
