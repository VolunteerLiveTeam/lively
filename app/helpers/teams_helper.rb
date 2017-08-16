module TeamsHelper

  def current_team
    current_user.current_team
  end

end