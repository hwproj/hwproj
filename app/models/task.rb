class Task < ActiveRecord::Base
	belongs_to :problem
	belongs_to :user
	
	has_many :submissions

	enum status: [ :not_submitted, :not_accepted, :accepted_partially, :accepted ]
end


