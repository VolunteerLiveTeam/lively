class EventsController < ApplicationController

  before_action :get_event, only: [:go, :show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :select_team, only: [:index, :new, :create]

  def go
  end

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
    @event = Event.new(params.require(:event).permit(:name, :description, :reddit_id).merge!(team: current_user.current_team))
    authorize @event
    if @event.save
      redirect_to @event
    else
      render 'new'
    end
  end

  def update
    authorize @event
    if @event.update(params.require(:event).permit(:name, :description))
      redirect_to @event
    else
      render 'edit'
    end
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

end
