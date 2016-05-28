class Job < ActiveRecord::Base
  belongs_to :student
  belongs_to :assignment, class_name: "Homework", foreign_key: "homework_id"

  has_many :tasks, dependent: :destroy
  has_many :awards, dependent: :destroy

  after_destroy :update_assignment

  private
    def update_assignment
      if self.assignment.jobs.where(done: false).empty?
          self.assignment.update(done: true)
      end
    end
end
