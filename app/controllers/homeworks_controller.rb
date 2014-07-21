class HomeworksController < ApplicationController
  def new
    @homework = Homework.new()
    @homework_number = Homework.count + 1
  end

  def create
    @homework = Homework.create(homework_params)
    redirect_to homeworks_path
  end

  def index
    @homeworks = Homework.all
  end

  private
    def homework_params
      params.require(:homework).permit(:number, problems_attributes: [:id, :text, :_destroy])
  end
end
