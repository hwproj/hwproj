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

  # def notes_number_hash
  #   Hash[
  #     self.terms.zip Term.where(course_id: self.id).collect { |term| term.tasks.
  #       collect { |task| task.notes } .flatten.count }
  #   ]
  # end

  def notes_number
    # Note.where(course_id: self.id, term: terms).count
    notes.count
  end

  # def accepted_tasks_number_hash
  #     Hash[
  #       self.terms.zip Term.where(course_id: self.id).collect { |term| term.tasks.flatten.
  #         select { |task| task.accepted?} .count }
  #     ]
  # end

  # def first_try_accepted_number_hash
  #   Hash[
  #     self.terms.zip Term.where(course_id: self.id).collect { |term| term.tasks.flatten.
  #       select { |task| task.accepted? && task.notes.count == 0 } .count }
  #   ]
  # end

  def first_try_accepted_number(term)
    Task.where(course_id: self.id, term: term, accepted: true, notes: 0).count
  end

  # def attempts_to_pass_number_hash
  #   Hash[
  #     self.terms.zip Term.where(course_id: self.id).collect { |term| term.tasks.
  #       collect { |task| task.submissions } .flatten.count }
  #   ]
  # end

  def attempts_to_pass_number(term)
    Submissions.where(course_id: self.id, term: @terms).count
  end

  def max_of_attempts_to_pass_number_hash
    Hash[
      self.terms.zip Term.where(course_id: self.id).
      select { |term| term.tasks.count > 0 }.collect { |term| term.tasks.
        max_by { |task| task.submissions.count } .submissions.count }
      ]
  end

  def max_of_attempts_to_pass_number
    Hash[ self.terms.zip Submissions.where(course_id: self.id, term: @terms, task: @tasks)]
  end

  def min_attempts_number_problem_hash
    Term.select(:tasks).where(course_id: self.id).

    Hash[
      self.terms.zip Term.select(:tasks).where(course_id: self.id).
      select { |term| term.tasks.count > 0 }.collect { |term| term.tasks.
        min_by { |task| task.submissions.count } .problem }
      ]
  end

  def max_attempts_number_problem_hash
    Hash[
      self.terms.zip Term.where(course_id: self.id).
      select { |term| term.tasks.count > 0 }.collect { |term| term.tasks.
        max_by { |task| task.submissions.count } .problem }
      ]
  end

  private
    def finish_terms
      self.terms.each { |term| term.update active: false }
    end
end
