class Task < ActiveRecord::Base
	belongs_to :problem
	belongs_to :user
	has_many :submissions, dependent: :destroy

	enum status: [ :not_submitted, :not_accepted, :accepted_partially, :accepted ]

	accepts_nested_attributes_for :submissions, :reject_if => :all_blank, :allow_destroy => true   
end


