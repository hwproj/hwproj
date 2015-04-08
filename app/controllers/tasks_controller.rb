class TasksController < ApplicationController
  before_action :set_task, only: [ :show, :update ]

  def show
    if (not signed_in?)
      authenticate_user!
    end

    if (not current_user.teacher?) && current_user.id != @task.student.user.id
      raise ActionController::RoutingError.new('Not Found')
    end

    @student = @task.student
    @submissions = @task.submissions #reverse order
    @submission = @submissions.first
  end

  def update
  	@task.update(params.require(:task).permit(:status))
    UserMailer.task_accepted_notify(@task).deliver if @task.accepted?

    update_job #needs update
  	redirect_to @task
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

    def update_job
      @job = @task.job
      @job.update(done: @job.tasks.select{|x| x.status != "accepted"}.empty?)
      if @job.done? && @job.assignment.awards.count < 3 && @job.assignment.assignment_type != "test"
        @job.awards.create(rank: @job.assignment.awards.count + 1)

        assignment = @job.assignment
        if assignment.jobs.where(done: false).empty?
          assignment.update(done: true)
        end
      end
    end
end
