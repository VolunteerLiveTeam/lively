class EventsController < ApplicationController

  before_action :get_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :select_team, only: [:index, :new, :create]

  def index
    @events = current_user.current_team.events
  end

  def show
  end

  def new
    @event = Event.new(team: current_user.current_team)
    authorize @event
  end

  def edit
    authorize @event
  end

  def create
    @event = Event.create(event_params.merge!(team: current_user.current_team))
    authorize @event
    redirect_to @event
  end

  def update
    authorize @event
    @event.update(event_params)
    redirect_to @event
  end

  def destroy
    authorize @event
    @event.destroy
    redirect_to event_path
  end

  private
    def get_event
      @event = Event.find(params[:id])      
    end

    def event_params
      params.require(:event).permit(:name, :description, :reddit_id)
    end

end
