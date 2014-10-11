class StudentsController < ApplicationController
  def create
    @student = Student.create(student_params)
    
    @student.term.homeworks do |homework| # а тесты?
      job = @student.jobs.create(homework_id: homework.id)

      homework.problems.each do |problem|
        job.tasks.create(problem_id: problem.id)
      end
    end

    redirect_to @student.term.course 
  end

  private
    def student_params
      params.require(:student).permit(:term_id).merge(user_id: current_user.id)
    end
end
