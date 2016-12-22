class WelcomeController < ApplicationController
  @@unread_notifications_desc = false
  @@all_notifications_desc = false

  def index
    @courses = Course.all_hash
    if signed_in?
      @section = 'unread'
      @section = params[:section] if params[:section]

      @@unread_notifications_desc = false
      @@all_notifications_desc = false

      unread_notifications = Notification.where(user_id: current_user.id, is_read: false).order(:last_event_time).paginate(page: params[:page])
      all_notifications = Notification.where(user_id: current_user.id).order(:last_event_time).paginate(page: params[:page])
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
      case params[:section]
        when 'unread'
          @@unread_notifications_desc = !@@unread_notifications_desc
          order = @@unread_notifications_desc ? :desc : :asc
          @notifications = Notification.where(user_id: current_user.id, is_read: false).order(last_event_time: order).paginate(page: params[:page])
        when 'show_all'
          @@all_notifications_desc = !@@all_notifications_desc
          order = @@all_notifications_desc ? :desc : :asc
          @notifications = Notification.where(user_id: current_user.id).order(last_event_time: order).paginate(page: params[:page])
      end
    end
  end
end
