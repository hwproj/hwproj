class HomeworksController < ApplicationController
  before_action :set_homework, only: [ :edit, :update, :destroy ]
  before_action :check_teacher, only: [ :new, :edit ]

  def new
    @homework = Homework.new()
  end

  def create
    @homework = Homework.new(homework_params)
    if @homework.valid?
      @homework.number = @homework.group.homeworks.count + 1
      @homework.save  
      redirect_to edit_homework_path(@homework)
    else
      redirect_to :back
    end
  end

  def index
    @homeworks = Homework.all
  end

  def edit
  end

  def update
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
    group = @homework.group
    @homework.destroy

    group_homeworks = @homework.group.homeworks
    for i in 0..group_homeworks.count - 1
      group_homeworks[i].update(number: i + 1)
    end

    redirect_to group
  end

  private

    def set_homework
      @homework = Homework.find(params[:id])
    end

    def check_teacher
      if (not signed_in?) || (not current_user.teacher?)
        raise ActionController::RoutingError.new('Not Found')
      end
    end

    def homework_params
      params.require(:homework).permit(:number, :group_id, problems_attributes: [ :id, :text, :_destroy ], links_attributes: [ :id, :url, :name, :_destroy ])
    end

  def enumerate_problems
    problems = @homework.problems
    for i in 0..problems.count - 1
      problems[i].update(number: i + 1)
    end
  end

  def create_tasks
    @homework.group.users.each do |user|
      job = user.jobs.create(homework_id: @homework.id)

      @homework.problems.each do |problem|
          user.tasks.create(problem_id: problem.id, homework_id: problem.homework_id, job_id: job.id)
      end
    end
  end
end
