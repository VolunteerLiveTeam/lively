class StaticController < ApplicationController
  
  before_action :select_team
  
  def index
  end
end
