class CoursesController < ApplicationController
  include Markdown
  helper_method :markdown
  before_action :set_course, only: [ :edit, :show, :update, :add_term, 
                                     :remove_last_term, :statistics ]

  def new
    @course = Course.new
  end

  def create
    @course = Course.create(course_params)
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

    term_data

    respond_to :html, :js
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

    @notes = { number: @course.notes_number_hash }
    @notes[:total] = @notes[:number].values.sum

    @first_try_accepted_tasks = 
        { number: @course.first_try_accepted_tasks_number_hash }
    @first_try_accepted_tasks[:total] = @first_try_accepted_tasks[:number].values.sum

    @accepted_tasks = { number: @course.accepted_tasks_number_hash }
    @accepted_tasks[:total] = @accepted_tasks[:number].values.sum

    @tries_to_pass_task = { number: @course.tries_to_pass_task_hash }
    @tries_to_pass_task[:total] = @tries_to_pass_task[:number].values.sum

    @max_tries_to_pass_task = { number: @course.max_tries_to_pass_task_hash }
    @max_tries_to_pass_task[:total] = @max_tries_to_pass_task[:number].values.max

    @max_tries_to_pass_problem = { number: @course.max_tries_to_pass_problem_hash,
      total: @course.total_max_tries_to_pass_problem}

    respond_to :html, :js
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

  def add_term
    @term = @course.terms.create()
    @terms = @course.terms.reverse

    term_data

    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render :show }
    end
  end

  def remove_last_term
    @course.terms.last.destroy
    @terms = @course.terms.reverse
    @term = @terms.first

    term_data

    respond_to do |format|
      format.html { redirect_to :show }
      format.js { render :show }
    end
  end

  private
  def course_params
    params.require(:course).permit(:group_name, :name).merge(teacher_id: current_user.id)
  end

  def set_course
    @course = Course.find(params[:id])
  end

  def term_data
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
end
