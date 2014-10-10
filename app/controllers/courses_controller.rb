class CoursesController < ApplicationController
  def new
    @course = Course.new
  end

  def create
    @course = Course.create(course_params)
    @course.create_term
    redirect_to @course
  end

  def show
    @course = Course.find(params[:id])
    @term = @course.terms.last

    @subscription = @term.students.where(user_id: current_user.id).first  
  end

  private
  def course_params
    params.require(:course).permit(:group_name, :name).merge(teacher_id: current_user.id)
  end
end
