class WelcomeController < ApplicationController
  def index
    @courses = Course.all

    if signed_in?
      if current_user.student?
        @student_feed = current_user.student_feed.paginate(page: params[:page])
        @deadline_tasks = current_user.deadline_tasks
        @overdue_tasks = current_user.overdue_tasks

      elsif current_user.teacher?
        @submissions = Submission.where(teacher_id: current_user.id).paginate(page: params[:page])
      end
    end
  end
end
