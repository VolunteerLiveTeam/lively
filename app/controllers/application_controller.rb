class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def select_team
    authenticate_user!
    if current_user.current_team.nil?
      redirect_to teams_path, alert: t('teams.no-selection')
    end
  end

end
