class WelcomeController < ApplicationController
  def index
    @courses = Course.all_hash

    if signed_in?
      @notifications = Notification.where(user_id: current_user.id).reverse.paginate(page: params[:page])
      if current_user.student?
        @deadline_tasks = current_user.deadline_tasks
        @overdue_tasks = current_user.overdue_tasks
      else
        @tasks_left = 0
        current_user.courses.each do |course|
          course.terms.last.students.where(approved: true).includes(jobs: :tasks).each do |student|
            @tasks_left += student.tasks_left_count
          end
        end
      end
    end
  end
end
