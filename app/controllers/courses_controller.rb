class CoursesController < ApplicationController
  before_action :set_course, only: [ :edit, :show, :update ]

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

    @teacher_id = @course.teacher_id

    if signed_in? && current_user.id == @teacher_id
      @teacher = true
      @students = @term.students
    else
      @students = @term.students.select{ |student| student.approved }
    end

    if signed_in? && current_user.student?
      @student = @term.students.where(user_id: current_user.id).first
    end

    if @student
      @tasks = @student.tasks
    end

    @tasks_left = 0
    @students.each do |student|
      @tasks_left += student.tasks_left_count
    end

    @assignments = @term.assignments.order(:id)

    @terms = @course.terms.reverse
  end

  def index
  end

  def edit
  end

  def update
    @course.update(course_params)
    redirect_to @course
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

  def set_course
    @course = Course.find(params[:id])
  end
end
