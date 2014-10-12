class HomeworksController < ApplicationController
  before_action :set_assignment, only: [ :edit, :update, :destroy ]

  def new
    @assignment = Homework.new
  end

  def create
    @assignment = Homework.new(assignment_params)
    @assignment.number = @assignment.term.assignments.select{|x| x.assignment_type == @assignment.assignment_type}.count + 1
    @assignment.save
    enumerate_problems
    create_jobs_and_tasks
    redirect_to @assignment.term.course
  end

  def edit
  end

  def update
    enumerate_problems
    
    @assignment.problems.each do |problem|
      unless Task.where(problem_id: problem.id).any?
        @assignment.jobs.each do |job|
          job.tasks.create(student_id: job.student.id, user_id: student.user.id, problem_id: problem.id)
        end
      end
    end

    redirect_to @assignment.term.course
  end

  def destroy
    term = @assignment.term

  end

  private
    def assignment_params
      params.require(:homework).permit(:assignment_type, :term_id, problems_attributes: [ :id, :text, :_destroy ], links_attributes: [ :id, :url, :name, :_destroy ])
    end

    def enumerate_problems
      problems = @assignment.problems
      for i in 1..problems.count
        problems[i - 1].update(number: i)
      end
    end

    def create_jobs_and_tasks
      @assignment.term.students.each do |student|
        job = student.jobs.create(homework_id: @assignment.id)

        @assignment.problems.each do |problem|
          job.tasks.create(student_id: job.student.id, user_id: student.user.id, problem_id: problem.id)
        end
      end
    end

    def set_assignment
      @assignment = Homework.find(params[:id])      
    end
end
