class WelcomeController < ApplicationController
  def index
    @courses = Course.all_hash
    if signed_in?
      @section = 'unread'
      @section = params[:section] if params[:section]
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
end
