class Job < ActiveRecord::Base
	belongs_to :student, foreign_key: "user_id"
  belongs_to :homework
  has_many :tasks
end
