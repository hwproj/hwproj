class CoursesController < ApplicationController
  include Markdown
  helper_method :markdown
  before_action :set_course, only: [ :edit, :show, :show_course, :update, :add_term, :delete_term, :statistics ]

  def new
    @course = Course.new
  end

  def create
    @course = Course.create(course_params.merge(teacher_id: current_user.id))
    if @course.valid?
      @course.terms.create()
      redirect_to @course
    else
      render "new"
    end
  end

  def show
    @terms = @course.terms.reverse

    @term = @course.terms.find_by(number: params[:term_number])
    raise ActionController::RoutingError.new 'Not Found' if @term.nil?

    @teacher_id = @course.teacher_id

    if signed_in? && current_user.id == @teacher_id
      @teacher = true
      @students = @term.students.includes(jobs: :tasks)
    else
      @students = @term.students.where(approved: true).includes(jobs: :tasks)
    end

    if signed_in? && current_user.student?
      @student = @term.students.find_by user_id: current_user.id
    end

    @tasks = @student.tasks if @student

    @tasks_left = 0
    @students.each do |student|
      @tasks_left += student.tasks_left_count
    end

    @assignments = @term.assignments.order(:id).includes(:problems)
  end

  def show_course
    redirect_to show_term_path(term_number: @course.terms.last.number)
  end

  def statistics
    @terms = @course.terms.reverse
    @teacher_id = @course.teacher_id
    @statistics = true

    if signed_in?
      if current_user.id == @teacher_id
        @teacher = true
      elsif current_user.student?
        @student = @terms.collect { |term| term.students.where(user_id: current_user.id) }.any?
      end
    end

    @notes_number = @course.notes_number_hash
    @notes_total = @notes_number.values.sum

    @first_try_accepted_tasks_number = @course.first_try_accepted_tasks_number_hash
    @first_try_accepted_tasks_total = @first_try_accepted_tasks_number.values.sum
  end

  def index
    @courses = Course.all_hash
  end

  def edit
  end

  def update
    @course.update(course_params)
    redirect_to @course
  end

  def add_term # todo rewrite with ajax
    @course.terms.create()

    redirect_to :back
  end

  def delete_term
    @course.terms.last.destroy
    redirect_to @course
  end

  private
  def course_params
    params.require(:course).permit(:group_name, :name, :default_max_grade)
  end

  def set_course
    @course = Course.find(params[:id])
  end
end
