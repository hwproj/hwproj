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

    if params[:term_number]
      @term = @course.terms.where(number: params[:term_number]).first
    else
      @term = @course.terms.last
    end

    raise ActionController::RoutingError.new('Not Found') if @term.nil?

    if signed_in? && current_user.teacher?
      @students = @term.students
    else
      @students = @term.students.select{ |student| student.approved }
    end

    @subscription = @term.students.where(user_id: current_user.id).first if signed_in?

    if signed_in? && current_user.student?
      @student = @term.students.where(user_id: current_user.id).first
    end
  end

  def index
  end

  def add_term
    @course = Course.find(params[:id])
    @course.create_term

    redirect_to :back
  end

  private
  def course_params
    params.require(:course).permit(:group_name, :name).merge(teacher_id: current_user.id)
  end
end
