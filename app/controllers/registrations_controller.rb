class RegistrationsController < Devise::RegistrationsController
  after_action :add_tasks, only: :save


  private
   
    def add_tasks
      Problem.all.each do |problem|
        @user.tasks.create(problem_id: problem.id) 
      end
      
    end

    def sign_up_params
      params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation)
    end
   
    def account_update_params
      params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation, :current_password)
    end
end