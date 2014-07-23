class TasksController < ApplicationController
  def index
  	@homeworks = Homework.all
  	@problems = Problem.all
  	@students = User.where( user_type: "student" )
  end

  def show
  	@task = Task.find(params[:id])
    @user = @task.user
    @submissions = @task.submissions
  end

  def update
  	@task = Task.find(params[:id])
  	@task.update_attributes(task_params)
  	redirect_to @task
  end

  private

  	def task_params
  		params.require(:task).permit(:status)
  	end
end
