class WelcomeController < ApplicationController
  def index
    @courses = Course.all_hash

    if signed_in?
      if current_user.student?
        @student_feed = current_user.student_feed.paginate(page: params[:page])
        @deadline_tasks = current_user.deadline_tasks
        @overdue_tasks = current_user.overdue_tasks

      elsif current_user.teacher?
        @submissions = Submission.where(teacher_id: current_user.id).paginate(page: params[:page])
        @numberOfTasks = 0
        
        @courses = current_user.courses

        @tasks_left_all = 0
        @tasks_left_of_last_terms = 0

        @courses.each do |course|
          course.terms.each do |term|
            students = term.students.where(approved: true).includes(jobs: :tasks)
            students.each do |student|
              @tasks_left_all += student.tasks_left_count
            end
          end

          course.terms.last.students.where(approved: true).includes(jobs: :tasks).each do |student|
            @tasks_left_of_last_terms += student.tasks_left_count
          end

        end

      end
    end
  end

end
