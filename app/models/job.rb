class Job < ActiveRecord::Base
	belongs_to :student, foreign_key: "user_id"
  belongs_to :homework
  has_many :tasks
  validates_uniqueness_of :user_id, :scope => :homework_id
end
