class Task < ActiveRecord::Base
  belongs_to :problem
  belongs_to :job
  belongs_to :student
  belongs_to :user

  has_many :submissions, dependent: :destroy
  has_many :notes, through: :submissions

  enum status: [ :not_submitted, :not_accepted, :accepted_partially, :accepted ]

  accepts_nested_attributes_for :submissions, :reject_if => :all_blank, :allow_destroy => true

  def name
    if problem.name || (not problem.name.blank?)
      name = problem.name
    else
      name = "#{problem.number}.#{problem.homework.number}"
    end

    name = "Тест, " + name if problem.homework.test?

    name
  end
end


