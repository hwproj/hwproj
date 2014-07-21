class TasksController < ApplicationController
  def index
  	@problems = Problem.all
  	@students = User.where( user_type: "student" )
  end
end
