class Note < ActiveRecord::Base
	validates :text, presence: true
	belongs_to :submission
end
