class WelcomeController < ApplicationController
  def index
    @courses = Course.all_hash

    if signed_in?
      @notifications = Notification.where(user_id: current_user.id).reverse.paginate(page: params[:page])
      if current_user.student?
        @deadline_tasks = current_user.deadline_tasks
        @overdue_tasks = current_user.overdue_tasks
      end
    end
  end
end
