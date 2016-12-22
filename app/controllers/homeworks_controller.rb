class HomeworksController < ApplicationController
  include ErrorsHelper
  include PermissionsHelper

  before_action :set_assignment, :check_edit_permissions, only: [ :edit, :update, :destroy ]

  def new
    @assignment = Homework.new
  end

  def create
    @assignment = Homework.new(assignment_params)
    if @assignment.valid?
      @assignment.number = @assignment.term.assignments.select{|x| x.assignment_type == @assignment.assignment_type}.count + 1
      @assignment.save
      enumerate_problems
      create_jobs_and_tasks
      redirect_to @assignment.term.course
    else
      render "new"
    end
  end

  def edit
    @problems = @assignment.problems.order(:id)
  end

  def update
    @assignment.update(assignment_params)
    enumerate_problems

    @assignment.problems.each do |problem|
      unless Task.where(problem: problem).any?
        @assignment.jobs.each do |job|
          job.tasks.create(student: job.student, user: job.student.user, problem: problem)
        end
      end
      problem.tasks.each do |task|
        task.update(problem_number: task.problem.number)
      end
    end

    redirect_to @assignment.term.course
  end

  def destroy
    term = @assignment.term
    @assignment.destroy
    update_assignments_numbers

    redirect_to term.course
  end

  private
    def assignment_params
      params.require(:homework).permit(:assignment_type, :term_id,
        problems_attributes: [ :id, :name, :text, :_destroy ],
        links_attributes: [ :id, :url, :name, :_destroy ])
    end

    def enumerate_problems
      @assignment.problems.order(:id).each_with_index do |problem, i|
        problem.update(number: i + 1)
      end
    end

    def create_jobs_and_tasks
      @assignment.term.students.each do |student|
        job = student.jobs.create(assignment: @assignment)

        @assignment.problems.each do |problem|
          job.tasks.create(student: job.student, user: student.user, problem: problem, problem_number: problem.number)
        end
      end
    end

    def update_assignments_numbers
      homeworks = @assignment.term.homeworks.order(:id)
      tests = @assignment.term.tests.order(:id)

      for i in 1..homeworks.count
        homeworks[i - 1].update(number: i)
      end

      for i in 1..tests.count
        tests[i - 1].update(number: i)
      end
    end

    def set_assignment
      @assignment = Homework.find(params[:id])
    end

    def check_edit_permissions
      Errors.forbidden(self) unless
          Permissions.has_edit_course_permissions?(current_user, @assignment.term.course)
    end
end
