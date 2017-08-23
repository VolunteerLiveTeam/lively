class ApplicationController < ActionController::Base
  include ScramUtils
  helper_method :current_holder
  helper_method :current_team
  helper_method :admin_enabled

  protect_from_forgery with: :exception

  def current_team
    @current_team ||= current_user.try(:current_team)
  end

  def admin_enabled
    @admin_enabled ||= current_user.try(:admin_enabled)
  end

  def select_team
    authenticate_user!
    if current_team.nil?
      redirect_to teams_path, alert: t('teams.no-selection')
    end
  end

  rescue_from ScramUtils::NotAuthorizedError do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to root_path, :alert => t('unauthorized') }
    end
  end

end
