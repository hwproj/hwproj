class StudentsController < ApplicationController
  def create
    @student = Student.create(student_params)
    redirect_to @student.term.course 
  end

  private
    def student_params
      params.require(:student).permit(:term_id).merge(user_id: current_user.id)
    end
end
