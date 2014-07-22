class SubmissionsController < ApplicationController
  def new
  end

  def create
    @task = current_user.tasks.where(problem_id: params[:submission][:task][:problem_id]).first
    @submission = @task.submissions.create(submission_params)
  end

  private
    def submission_params
      params[:submission][:user_id] = current_user.id
      params[:submission][:version] = @task.submissions.count + 1
      params.require(:submission).permit(:text, :user_id, :version)
    end
end
