class AdminController < ApplicationController

  before_action :authenticate_user!

  def toggle
    unless current_user.admin
      redirect_to root_path, alert: t('admin.unauthorized')
    else
      current_user.toggle_admin
      redirect_to root_path, notice: t('admin.toggled')
    end
  end

end
