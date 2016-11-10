class Course < ActiveRecord::Base
  belongs_to :teacher, class_name: 'User'

  has_many :terms, dependent: :destroy

  after_save :finish_terms, unless: :active?

  validates :name, presence: {message: 'Введите название.'}
  validates :group_name, presence: {message: 'Введите номер группы'}

  def self.all_hash
    {
      active: Course.where(active: true).order(:group_name),
      finished: Course.where(active: false).order(:group_name)
    }
  end

  def notes_number_hash
    Hash[
      self.terms.zip Term.where(course_id: self.id).collect { |term| term.tasks.
        collect { |task| task.notes } .flatten.count }
    ]
  end

  def accepted_tasks_number_hash
      Hash[
        self.terms.zip Term.where(course_id: self.id).collect { |term| term.tasks.flatten.
          select { |task| task.accepted?} .count }
      ]
  end

  def first_try_accepted_tasks_number_hash
    Hash[
      self.terms.zip Term.where(course_id: self.id).collect { |term| term.tasks.flatten.
        select { |task| task.accepted? && task.notes.count == 0 } .count }
    ]
  end

  def attempts_to_pass_tasks_number_hash
    Hash[
      self.terms.zip Term.where(course_id: self.id).collect { |term| term.tasks.
        collect { |task| task.submissions } .flatten.count }
    ]
  end

  def maximum_of_attempts_to_pass_task_number_hash
    Hash[
      self.terms.zip Term.where(course_id: self.id).collect { |term| term.tasks.
        max_by { |task| task.submissions.count } .submissions.count }
      ]
  end

  def problem_with_minimum_number_of_attempts_hash
    Hash[
      self.terms.zip Term.where(course_id: self.id).collect { |term| term.tasks.
        min_by { |task| task.submissions.count } .problem }
      ]
  end

  def problem_with_maximum_number_of_attempts_hash
    Hash[
      self.terms.zip Term.where(course_id: self.id).collect { |term| term.tasks.
        max_by { |task| task.submissions.count } .problem }
      ]
  end

  private
    def finish_terms
      self.terms.each { |term| term.update active: false }
    end
end
