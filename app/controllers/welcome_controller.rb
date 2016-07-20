class WelcomeController < ApplicationController
  def index
    @courses = Course.all_hash
    if signed_in?
      @section = 'unread'
      @section = params[:section] if params[:section]
      @notifications = Notification.where(user_id: current_user.id).order(last_event_time: :desc).paginate(page: params[:page])
      if current_user.student?
        @deadline_tasks = current_user.deadline_tasks
        @overdue_tasks = current_user.overdue_tasks
      end
      case @section
        when 'unread'
          @active_tab_name = 'Непрочитанные'
        when 'show_all'
          @active_tab_name = 'Показать все'
        when 'important'
          @active_tab_name = 'Важное'
      end
    end
  end
end
