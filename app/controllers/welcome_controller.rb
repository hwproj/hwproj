class WelcomeController < ApplicationController
  def index
  	@submissions = Submission.paginate(page: params[:page])
  	@groups = Group.all
  end
end
