class RolesController < ApplicationController
  load_and_authorize_resource
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @roles = %i[admin manager monitor]

    render json: { roles: @roles }
  end

  def add_admin
    @user = User.find(user_params)
    @user.add_role :admin

    render json: UserSerializer.new(@user), status: :created
  end

  def add_manager
    @user = User.find(user_params)
    @project = Project.find(project_params)
    @user.add_role :manager, @project

    render json: UserSerializer.new(@user), status: :created
  end

  def add_monitor
    @user = User.find(user_params)
    @team = if current_user.is_admin?
              Team.find(team_params)
            else
              project_ids = current_user.managed_projects.map(&:id)
              Team.find_by!(project_id: project_ids, id: team_params)
            end

    @user.add_role :monitor, @team

    render json: UserSerializer.new(@user), status: :created
  end

  def remove_admin
    @user = User.find(user_params)
    @user.remove_role :admin
  end

  def remove_manager
    @user = User.find(user_params)
    @project = Project.find(project_params)
    @user.remove_role :manager, @project
  end

  def remove_monitor
    @user = User.find(user_params)
    @team = Team.find(team_params)
    @user.remove_role :monitor, @team
  end

  private

  def user_params
    params.require(:role).permit(:user_id)[:user_id]
  end

  def project_params
    params.require(:role).permit(:project_id)[:project_id]
  end

  def team_params
    params.require(:role).permit(:team_id)[:team_id]
  end
end
