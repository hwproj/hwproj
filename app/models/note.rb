class Note < ActiveRecord::Base
	validates :text, :submission_id, presence: true
	belongs_to :submission
end
