class HomeworksController < ApplicationController


  def new
    @homework = Homework.new()
    @homework_number = Homework.count + 1
    @groups = Group.all
  end

  def create
    @homework = Homework.create(homework_params)
    enumerate_problems
    create_tasks
    redirect_to @homework.group
  end

  def index
    @homeworks = Homework.all
  end

  def edit
    @homework = Homework.find(params[:id])
    @homework_number = @homework.number
    @groups = Group.all
  end

  def update
    @homework = Homework.find(params[:id])
    @homework.update(homework_params)
    redirect_to @homework.group
  end

  private
    def homework_params
      params.require(:homework).permit(:number, :group_id, problems_attributes: [:id, :text, :_destroy])
  end

  def enumerate_problems
    problems = @homework.problems
    for i in 1..problems.count
      problems[i-1].update(number: i)
    end
  end

  def create_tasks
    @homework.problems.each do |problem|
      User.all.each do |user|
        user.tasks.create(problem_id: problem.id) if user.student?
      end
    end
  end
end
