class Job < ActiveRecord::Base
  belongs_to :student
  belongs_to :assignment, class_name: "Homework", foreign_key: "homework_id"

  has_many :tasks, dependent: :destroy
  has_many :awards, dependent: :destroy
end
