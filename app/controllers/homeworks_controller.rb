class HomeworksController < ApplicationController

  def new
    @homework = Homework.new()
    @homework_number = Homework.count + 1
  end

  def create
    @homework = Homework.create(homework_params)
    create_tasks
    redirect_to homeworks_path
  end

  def index
    @homeworks = Homework.all
  end

  private
    def homework_params
      params[:homework][:number] = @homework_number
      params.require(:homework).permit(:number, problems_attributes: [:id, :text, :_destroy])
  end

  def create_tasks
    @homework.problems.each do |problem|
      User.all.each do |user|
        user.tasks.create(problem_id: problem.id) if user.student?
      end
    end
  end
end
