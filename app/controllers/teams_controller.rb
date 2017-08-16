class TeamsController < ApplicationController

  before_action :get_team, only: [:select, :show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :select, :new, :edit, :create, :update, :destroy]

  def index
    @teams = current_user.groups
  end

  def select
    current_user.current_team = @team
    redirect_to root_path, flash: {notice: t('teams.switched', team: @team.name)}
  end

  def show
  end

  def new
    @team = Team.new
  end

  def edit
  end

  def create
    @team = Team.create(team_params)
    redirect_to @team
  end

  def update
    @team.update(team_params)   
  end

  def destroy
    @team.destroy
    redirect_to teams_path
  end

  private
    def get_team
      @team = Team.find(params[:id])      
    end

    def team_params
      params.require(:team).permit(:name)
    end

end
