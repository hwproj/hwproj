class Term < ActiveRecord::Base
  belongs_to :course

  has_many :students, dependent: :destroy
  has_many :assignments, class_name: 'Homework', dependent: :destroy
  has_many :jobs, through: :assignments
  has_many :tasks, through: :students
  has_many :submissions, through: :tasks

  def group_name
    course.group_name
  end

  def course_name
    course.name
  end

  def homeworks
    assignments.where(assignment_type: "homework")
  end

  def tests
    assignments.where(assignment_type: "test")
  end
end
