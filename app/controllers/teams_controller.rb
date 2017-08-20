class TeamsController < ApplicationController

  before_action :get_team, except: [:index]
  before_action :authenticate_user!

  def index
    @teams = current_user.groups
  end

  def list_members
    @managers = @team.members.as(:manager)
    @members = @team.members.sort {|u| @managers.include?(u) ? 0 : 1}
    render 'members'
  end

  def add_member
    authorize @team, :edit
    raise "TODO"
  end

  def remove_member
    authorize @team, :edit

    user = User.find(params[:user])
    user.groups.destroy @team
    @team.users.delete user

    if user.current_team == @team
      user.current_team = nil
    end

    redirect_to list_members_team_path(@team), notice: t('teams.members.removed')
  end

  def select
    authorize @team
    current_user.current_team = @team
    redirect_to root_path, flash: {notice: t('teams.switched', team: @team.name)}
  end

  def new
    authorize Team
    @team = Team.new
  end

  def edit
    authorize @team
  end

  def create
    @team = Team.new(team_params)
    authorize @team
    if @team.save
      @team.add current_user, as: :manager
      redirect_to events_path
    else
      render 'new'
    end
  end

  def update
    authorize @team
    if @team.update(team_params)
      redirect_to events_path
    else
      render 'edit'
    end
  end

  def destroy
    authorize @team
    @team.destroy
    redirect_to teams_path
  end

  private
    def get_team
      @team = Team.find(params[:id])      
    end

    def team_params
      params.require(:team).permit(:name, :logo, :description)
    end

end
