class NotificationsController < ApplicationController
  respond_to :js
  helper_method :resource

  def update
    update_resource
    respond_with resource
  end

  private

  def update_resource
    resource.update!(permitted_params)
  end

  def resource
    @resource ||= current_user.notifications.find(params[:id])
  end

  def permitted_params
    params.require(:notification).permit(:is_read)
  end
end
