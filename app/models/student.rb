class Student < ActiveRecord::Base
  belongs_to :user
  belongs_to :term

  has_many :jobs, dependent: :destroy
  has_many :tasks, through: :jobs
  has_many :awards, through: :jobs
  has_many :submissions, through: :tasks

  def full_name
    user.full_name
  end

  def table_name
    user.surname + " " + user.name
  end

  def tasks_left_count
    tasks.where.not(status: 3).count # status: "accepted"
  end
end
