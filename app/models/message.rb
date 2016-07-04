class Message < ActiveRecord::Base

	belongs_to :student
	belongs_to :task
    belongs_to :teacher, class_name: 'User'


end
