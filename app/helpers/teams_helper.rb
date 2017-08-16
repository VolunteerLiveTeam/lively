module TeamsHelper

  def current_team
    unless user_signed_in?
      return nil
    end
    current_user.current_team
  end

end