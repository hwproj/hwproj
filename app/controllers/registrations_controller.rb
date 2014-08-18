class RegistrationsController < Devise::RegistrationsController
  after_action :add_tasks, only: :create


  private
   
    def add_tasks
      if @user.valid?
        @user.group.problems.each do |problem|
          @user.tasks.create(problem_id: problem.id) 
        end
      end
    end

    def sign_up_params
      params.require(:user).permit(:name, :surname, :group_id, :gender, :email, :password, :password_confirmation)
    end
   
    def account_update_params
      params.require(:user).permit(:name, :surname, :group_id, :gender, :email, :password, :password_confirmation, :current_password)
    end
end