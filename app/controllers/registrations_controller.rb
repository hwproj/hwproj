class RegistrationsController < Devise::RegistrationsController
  after_action :add_tasks, only: :create
  # after_action :send_notify, only: :create

  def approve_student
    redirect_to :root if (not current_user.teacher?)

    @student = User.find(params[:id])
    redirect_to :back if @student.nil?

    @student.update(approved: true)
    redirect_to group_path(@student.group)
  end

  def destroy_student
    redirect_to :root if (not current_user.teacher?)

    @student = User.find(params[:id])
    @group = @student.group

    @student.destroy
    redirect_to @group
  end

  private
   
    def add_tasks
      if @user.valid?

        @user.group.homeworks.each do |homework|
          job = @user.jobs.create(homework_id: homework.id)

          homework.problems.each do |problem|
            job.tasks.create(problem_id: problem.id, user_id: @user.id, homework_id: homework.id)
          end
        end
      end
    end

    def send_notify
      UserMailer.new_student_notify(@user).deliver
    end

    def sign_up_params
      params.require(:user).permit(:name, :surname, :group_id, :gender, :email, :password, :password_confirmation)
    end
   
    def account_update_params
      params.require(:user).permit(:name, :surname, :group_id, :gender, :email, :password, :password_confirmation, :current_password)
    end
end