class WelcomeController < ApplicationController
  def index
  	@submissions = Submission.paginate(page: params[:page])
  	@groups = Group.all

  	if signed_in? && current_user.student?
  		@student_feed = current_user.student_feed.paginate(page: params[:page])
  		@deadline_tasks = current_user.deadline_tasks
  		@overdue_tasks = current_user.overdue_tasks
  	end

  end
end
