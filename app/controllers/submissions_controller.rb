class SubmissionsController < ApplicationController
  def new
    @submission = Submission.new
    @submission.task_id = params[:task_id]
  end

  def create
    redirect_to new_submission_path if params[:submission][:task_id].nil?

    @task = Task.find(params[:submission][:task_id])
    @task.update status: :waiting if @task.not_submitted? || @task.waiting?
    @submission = Submission.create(submission_params)
    UserMailer.new_submission_notify(@submission).deliver
    redirect_to @submission.task
  end

  private
    def submission_params
      params.require(:submission).permit(:text, :task_id, :file, :url).merge(user_id: current_user.id, student_id: @task.student.id, version: @task.submissions.count + 1, teacher_id: @task.job.assignment.term.course.teacher.id)
    end
end