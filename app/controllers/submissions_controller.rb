class SubmissionsController < ApplicationController
  def new
    @submission = Submission.new
    @submission.task_id = params[:task_id]
  end

  def create
    redirect_to new_submission_path if params[:submission][:task_id].nil?

    @task = Task.find(params[:submission][:task_id])
    @task.update status: :new_submission if @task.not_submitted? || @task.new_submission?
    @task.update status: :new_submission_with_notes if @task.accepted_partially?
    @submission = Submission.create(submission_params)
    UserMailer.new_submission_notify(@submission).deliver
    Notification.new_event(user: @submission.teacher, task: @submission.task, event_type: :new_submission, event_time: @submission.created_at)

    url = @submission.url unless @submission.url.blank?

    # GitHub pull request hooking
    begin
      if url && URI.parse(url).host == "github.com" && url["/pull/"]
        @submission.update pull_request: true

        session[:submission] = @submission.id
        client_id = ENV["GITHUB_CLIENT_ID"]
        redirect_to "https://github.com/login/oauth/authorize?scope=write:repo_hook&client_id=#{ client_id }" and return
      end
    rescue => e
      @submission.update url: ""
    end

    redirect_to @submission.task
  end

  private
    def submission_params
      params.require(:submission).permit(:text, :task_id, :file, :url).merge(user_id: current_user.id, student_id: @task.student.id, version: @task.submissions.count + 1, teacher_id: @task.job.assignment.term.course.teacher.id)
    end
end
