class TasksController < ApplicationController
  before_action :set_task, only: [ :show, :update ]

  def show
    if (not signed_in?)
      authenticate_user!
    end

    if (not current_user.teacher?) && current_user.id != @task.user.id
      raise ActionController::RoutingError.new('Not Found')
    end
    @user = @task.user
    @submissions = @task.submissions
    @last_submission = @submissions.first
  end

  def update
  	@task.update(task_params)
    if @task.accepted?
      @task.notes.each do |note|
        note.update(fixed: true)
      end
      UserMailer.task_accepted_notify(@task).deliver
    end
  	redirect_to @task
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

  	def task_params
  		params.require(:task).permit(:status)
  	end
end
