class Term < ActiveRecord::Base
  before_create :set_number
  before_create :finish_previous
  after_destroy :make_active_previous
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

  private
    def set_number
      self.number = self.course.terms.count + 1
    end

    def finish_previous
      course.terms.last.update active: false if course.terms.any?
    end

    def make_active_previous
      course.terms.last.update active: true if course.terms.any?
    end
end
