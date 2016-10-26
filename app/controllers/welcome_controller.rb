class WelcomeController < ApplicationController
  @@notifications_desc = true
  respond_to :js, :html

  def index
    @courses = Course.all_hash
    if signed_in?
      @section = 'unread'
      @section = params[:section] if params[:section]
      @@notifications_desc = true
      Rails.logger.debug("My is_desc in index: #{@@notifications_desc.inspect}")
      unread_notifications = Notification.where(user_id: current_user.id, is_read: false).order(:last_event_time).paginate(page: params[:page])
      all_notifications = Notification.where(user_id: current_user.id).order(last_event_time: :desc).paginate(page: params[:page])
      if current_user.student?
        @deadline_tasks = current_user.deadline_tasks
        @overdue_tasks = current_user.overdue_tasks
      end
      case @section
        when 'unread'
          @active_tab_name = 'Непрочитанные'
          @notifications = unread_notifications
        when 'show_all'
          @active_tab_name = 'Показать все'
          @notifications = all_notifications
        when 'important'
          @active_tab_name = 'Важное'
      end
    end
  end

  def update
    if signed_in?
      Rails.logger.debug("My object: #{@@notifications_desc.inspect}")
      @@notifications_desc = !@@notifications_desc
      Rails.logger.debug("Should not be my object: #{@@notifications_desc.inspect}")
      if @@notifications_desc
        @notifications = Notification.where(user_id: current_user.id).order(last_event_time: :desc).paginate(page: params[:page])
      else
        @notifications = Notification.where(user_id: current_user.id).order(last_event_time: :asc).paginate(page: params[:page])
      end
    end
  end
end
