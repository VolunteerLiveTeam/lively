class TeamsController < ApplicationController

  before_action :get_team, only: [:select, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :select, :new, :edit, :create, :update, :destroy]

  def index
    @teams = current_user.groups
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
