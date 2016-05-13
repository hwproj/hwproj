class TasksController < ApplicationController
  include Markdown
  helper_method :markdown
  before_action :set_task, only: [ :show, :update, :switch_chat]

  def show
    if (not signed_in?)
      authenticate_user!
    end

    course = @task.problem.homework.term.course

    @is_teacher = current_user == course.teacher
    @is_student = current_user == @task.user

    if @is_student || @is_teacher || current_user.admin?
      @student     = @task.student
      @submissions = @task.submissions #reverse order
      @submission  = @submissions.first
    else
      raise ActionController::RoutingError.new('Not Found')
    end

    if @is_teacher && @submission
      Notification.make_read(user: @submission.teacher, task: @task)
    elsif @is_student
      Notification.make_read(user: @student.user, task: @task)
    end
    
    @is_chat_shown = params[:chat] == 'on'
    @chat_button_title = @is_chat_shown ? 'Скрыть чат' : 'Показать чат'
  end

  def update
  	@task.update(params.require(:task).permit(:status))
    @task.touch
    if (params[:task][:status] == "accepted")
      event_type = :task_accepted
    else
      event_type = :task_accepted_partially
    end
    Notification.new_event(task: @task, user: @task.user, event_type: event_type, event_time: @task.updated_at)
    
    UserMailer.task_accepted_notify(@task).deliver if @task.accepted?

  	redirect_to @task
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def switch_chat
    end
end
