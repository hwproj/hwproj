class WelcomeController < ApplicationController
  def index
  	@submissions = Submission.all
  end
end
