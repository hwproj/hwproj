class Homework < ActiveRecord::Base
    after_create :create_tasks
    has_many :problems
    accepts_nested_attributes_for :problems, :reject_if => :all_blank, :allow_destroy => true

  private
    def create_tasks
      self.problems.each do |problem|
        User.all.each do |user|
          user.tasks.create(problem_id: problem.id) if user.student?
        end
      end
    end

   
end
