class SubmissionsController < ApplicationController
  def new
  end

  def create
    current_user.tasks.find(2)
    Submission.create(submission_params)
  end

  private
    def submission_params
      params.require(:submission).permit(:task)
    end
end
