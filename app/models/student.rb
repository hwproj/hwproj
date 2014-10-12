class Student < ActiveRecord::Base
  belongs_to :user
  belongs_to :term

  has_many :jobs
  has_many :tasks, through: :jobs
  has_many :awards, through: :jobs
  has_many :submissions, through: :tasks
end
