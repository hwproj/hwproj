class Task < ActiveRecord::Base
    belongs_to :problem
    belongs_to :user
    has_many :submissions, dependent: :destroy
    has_many :notes, through: :submissions

    enum status: [ :not_submitted, :not_accepted, :accepted_partially, :accepted ]

    accepts_nested_attributes_for :submissions, :reject_if => :all_blank, :allow_destroy => true

    validates_uniqueness_of :user_id, :scope => :problem_id

    def name
    	problem.homework.number.to_s + "." + problem.number.to_s
    end
end


