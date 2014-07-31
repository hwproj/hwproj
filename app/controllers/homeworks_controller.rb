class HomeworksController < ApplicationController


  def new
    @homework = Homework.new()
    @groups = Group.all
  end

  def create
    @homework = Homework.new(homework_params)
    if @homework.valid?
      @homework.number = @homework.group.homeworks.count + 1
      @homework.save  
      enumerate_problems
      create_tasks
      redirect_to @homework.group
    else
      redirect_to :back
    end
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
    if @homework.valid?
      @homework.update(homework_params)
      enumerate_problems
      create_tasks
      redirect_to @homework.group
    else
      redirect_to :back
    end
  end

  def destroy
    @homework = Homework.find(params[:id])
    @group = @homework.group
    @homework.destroy
    redirect_to @group
  end


  private
    def homework_params
      params.require(:homework).permit(:number, :group_id, problems_attributes: [:id, :text, :_destroy])
  end

  def enumerate_problems
    problems = @homework.problems
    for i in 0..problems.count - 1
      problems[i].update(number: i + 1)
    end
  end

  def create_tasks
    @homework.problems.each do |problem|
      @homework.group.users.each do |user|
          user.tasks.create(problem_id: problem.id)
      end
    end
  end
end
