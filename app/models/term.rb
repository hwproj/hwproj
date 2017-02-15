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

  def accepted_tasks_count
    tasks.accepted.count
  end

  def first_try_accepted_tasks_count
    tasks.accepted.without_notes.count
  end

  def notes_count
    tasks.map{ |task| task.notes_count }.sum
  end

  def tasks_submissions_count_list
    tasks.map{ |task| task.submissions_count }
  end

  def min_attempts_to_pass_problem
    tasks.min_by{ |task| task.submissions_count }
  end

  def max_attempts_to_pass_problem
    tasks.max_by{ |task| task.submissions_count }
  end

  private
    def set_number
      self.number = self.course.terms.count + 1
    end

    def finish_previous
      course.terms.last.update active: false if course.terms.any?
    end

    def make_active_previous
      course.terms.last.update active: true if course.terms.count > 1
    end
end
