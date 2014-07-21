class Task < ActiveRecord::Base
	belongs_to :problem
	belongs_to :user
	
	has_many :submissions

end
