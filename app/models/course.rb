class Course < ActiveRecord::Base
  belongs_to :teacher, class_name: 'User'

  has_many :terms, dependent: :destroy

  after_save :finish_terms, unless: :active?

  validates :name, presence: {message: 'Введите название.'}
  validates :group_name, presence: {message: 'Введите номер группы'}
  validates :default_max_grade, presence: { message: 'Введите оценку по умолчанию' }

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

  def first_try_accepted_tasks_number_hash
    Hash[
      self.terms.zip Term.where(course_id: self.id).collect { |term| term.tasks.flatten.
        select { |task| task.accepted? && task.notes.count == 0 } .count }
    ]
  end

  private
    def finish_terms
      self.terms.each { |term| term.update active: false }
    end
end
