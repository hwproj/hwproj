class NotificationsController < ApplicationController
	respond_to :js
	def update
		@notification = Notification.find(params[:id])
		@notification.is_read = params[:is_read]
		@notification.save!
		render nothing: true
	end
end
