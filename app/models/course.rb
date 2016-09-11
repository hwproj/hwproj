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

  def first_try_accepted_tasks_number_hash
    Hash[
      self.terms.zip Term.where(course_id: self.id).collect { |term| term.tasks.flatten.
        select { |task| task.accepted? && task.notes.count == 0 } .count }
    ]
  end

  def accepted_tasks_number_hash
    Hash[
      self.terms.zip Term.where(course_id: self.id).collect { |term| term.tasks.flatten.
        select { |task| task.accepted? }.count }
    ]
  end

  def tries_to_pass_task_hash
    Hash[
      self.terms.zip Term.where(course_id: self.id).collect { |term| term.submissions.count }
    ]
  end

  def max_tries_to_pass_task_hash
    Hash[
      self.terms.zip Term.where(course_id: self.id).collect { |term| term.tasks.flatten.
        collect { |task| task.submissions.count }.max || 0 }
    ]
  end

  def max_tries_to_pass_problem_hash
    Hash[
      self.terms.zip Term.where(course_id: self.id).collect { |term| 
        max_tries_to_pass_problem_name term.homeworks.flatten.
        collect { |homework| homework.problems }.flatten }
    ]
  end  

  def total_max_tries_to_pass_problem
    max_tries_to_pass_problem_name(self.terms.collect { |term| term.homeworks.flatten.
        collect { |homework| homework.problems } }.flatten(2), :total)
  end

  private
    def finish_terms
      self.terms.each { |term| term.update active: false }
    end

    def max_tries_to_pass_problem_name problems, *args
      problem_hash = Hash[
        problems.zip problems.collect { |problem| problem.tasks.collect{ |task| task.
                                  submissions}.flatten.count }
      ]

      result_problem = nil
      problem_hash.each do |problem, tasks_number|
        result_problem ||= { problem: problem, tasks_number: tasks_number }
        if tasks_number > result_problem[:tasks_number]
          result_problem[:problem] = problem
          result_problem[:tasks_number] = tasks_number
        end
      end

      if result_problem
        result_problem[:problem].name || result_problem[:problem].homework.term.number.to_s + "-" +
                                         result_problem[:problem].homework.number.to_s + "-" +
                                         result_problem[:problem].number.to_s
      else
        "Задач нет"
      end
    end
end
