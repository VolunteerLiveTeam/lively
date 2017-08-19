class ApplicationController < ActionController::Base
  include ScramUtils
  helper_method :current_holder

  protect_from_forgery with: :exception
  before_action :set_team

  def select_team
    authenticate_user!
    if current_user.current_team.nil?
      redirect_to teams_path, alert: t('teams.no-selection')
    end
  end

  def set_team
    if user_signed_in?
      @current_team = current_user.current_team
    end
  end

  rescue_from ScramUtils::NotAuthorizedError do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to root_path, :alert => "You are not authorized to perform that action at this time. Please try signing in!" }
    end
  end

end
