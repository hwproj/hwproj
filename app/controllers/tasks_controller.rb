class TasksController < ApplicationController
  def index
  	@homeworks = Homework.all
  	@problems = Problem.all
  	@students = User.where( user_type: "student" )
  end

  def show
  	@task = Task.find(params[:id])
  end
end
