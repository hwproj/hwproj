class Term < ActiveRecord::Base
  belongs_to :course

  has_many :students, dependent: :destroy
  has_many :assignments, class_name: 'Homework', dependent: :destroy

  def group_name
    course.group_name
  end

  def homeworks
    assignments.where(assignment_type: "homework")
  end

  def tests
    assignments.where(assignment_type: "test")
  end
end
