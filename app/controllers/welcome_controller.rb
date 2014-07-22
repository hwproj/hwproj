class WelcomeController < ApplicationController
  def index
  	@submissions = Submission.paginate(page: params[:page])
  end
end
