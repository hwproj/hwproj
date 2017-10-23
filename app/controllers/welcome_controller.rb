class WelcomeController < ApplicationController
  helper_method :sort_order

  def index
    @courses = Course.all_hash

    if signed_in?
      @section = 'unread'
      @section = params[:section] if params[:section]

      if current_user.student?
        @deadline_tasks = current_user.deadline_tasks
        @overdue_tasks = current_user.overdue_tasks
      end

      case @section
        when 'unread'
          @active_tab_name = 'Непрочитанные'
          @notifications = current_user.notifications
                                       .where(is_read: false)
                                       .order(last_event_time: sort_order)
                                       .paginate(page: params[:page])
        when 'show_all'
          @active_tab_name = 'Показать все'
          @notifications = current_user.notifications
                                       .order(last_event_time: sort_order)
                                       .paginate(page: params[:page])
        when 'important'
          @active_tab_name = 'Важное'
      end
    end
  end

  private

  def sort_order
    params[:direction] == 'asc' ? :asc : :desc
  end
end
