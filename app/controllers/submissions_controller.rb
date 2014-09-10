class SubmissionsController < ApplicationController
  def new
    @submission = Submission.new
    @submission.task_id = params[:task_id]
  end

  def create
    redirect_to new_submission_path if params[:submission][:task_id].nil?

    @task = Task.find(params[:submission][:task_id])
    @submission = Submission.create(submission_params)
    UserMailer.new_submission_notify(@submission).deliver
    redirect_to @submission.task
  end

  def update
    @submission = Submission.find(params[:submission][:id])
    @submission.update_attributes(notes_params)

    if @submission.notes.any?
      @submission.task.update(status: "accepted_partially")
    end

    redirect_to @submission.task
  end

  private

    def notes_params
      params.require(:submission).permit(notes_attributes: [:id, :text])
    end

    def submission_params
      params[:submission][:user_id] = current_user.id
      params[:submission][:version] = @task.submissions.count + 1
      params.require(:submission).permit(:text, :user_id, :task_id, :version, :file)
    end
end