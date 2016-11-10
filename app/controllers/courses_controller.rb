class CoursesController < ApplicationController
  include Markdown
  include ErrorsHelper
  include PermissionsHelper
  helper_method :markdown

  before_action :set_course, only: [ :edit, :show, :update, :add_term, :delete_term, :destroy, :statistics ]
  before_action :check_edit_permissions, only: [ :edit, :update, :add_term, :delete_term, :destroy ]

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

    if params[:term_number]
      @term = @course.terms.find_by number: params[:term_number]
    else
      @term = @course.terms.last
    end
    raise ActionController::RoutingError.new 'Not Found' if @term.nil?

    @teacher_id = @course.teacher_id

    if signed_in? && current_user.id == @teacher_id
      @teacher = true
      @students = @term.students.includes(jobs: :tasks)
    else
      @students = @term.students.where(approved: true).includes(jobs: :tasks)
    end

    if signed_in? && current_user.student?
      @student = @term.students.find_by user: current_user
    end

    @tasks = @student.tasks if @student

    @tasks_left = 0
    @students.each do |student|
      @tasks_left += student.tasks_left_count
    end

    @assignments = @term.assignments.order(:id).includes(:problems)
  end

  def statistics
    @terms = @course.terms
    @teacher_id = @course.teacher_id
    @statistics = true

    if signed_in?
      if current_user.id == @teacher_id
        @teacher = true
      elsif current_user.student?
        @student = Student.where(approved: true,  user_id: current_user, term: @terms).any?
      end
    end

    @notes = @terms.map { |term| term.notes_count }
    @notes_total = @notes.sum

    @accepted_tasks = @terms.map { |term| term.accepted_tasks_count }
    @accepted_tasks_total = @accepted_tasks.sum

    @attempts_to_pass = @terms.map { |term| term.submissions_count.sum }
    @attempts_to_pass_total = @attempts_to_pass.sum

    @max_attempts_to_pass_one_task = @terms.map { |term| term.submissions_count.max }
    @max_attempts_to_pass_one_task_total = @max_attempts_to_pass_one_task.max

    @problems_with_min_attempts_to_pass = @terms.map { |term| term.min_attempts_to_pass_problem.problem.get_name }

    @problems_with_max_attempts_to_pass = @terms.map { |term| term.max_attempts_to_pass_problem.problem.get_name }
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

  def destroy
    @course.destroy
    redirect_to courses_path
  end

  private
  def course_params
    params.require(:course).permit(:group_name, :name, :active)
  end

  def set_course
    @course = Course.find(params[:id])
  end

  def check_edit_permissions
    Errors.forbidden(self) unless
        Permissions.has_edit_course_permissions?(current_user, @course)
  end
end
