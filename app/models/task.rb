class Task < ActiveRecord::Base
  belongs_to :problem
  belongs_to :job
  belongs_to :student
  belongs_to :user

  counter_culture :student,
    :column_name => Proc.new {|model| !model.accepted? ? 'tasks_left_count' : nil },
    :column_names => { ["NOT tasks.status = ?", 3] => 'tasks_left_count' } # accepted status equals 3

  has_many :notifications, dependent: :destroy
  has_many :submissions, dependent: :destroy
  has_many :notes, through: :submissions

  #chat
  has_many :messages, dependent: :destroy

  enum status: [ :not_submitted, :new_submission, :accepted_partially, :accepted, :new_submission_with_notes ]

  accepts_nested_attributes_for :submissions, :reject_if => :all_blank, :allow_destroy => true

  after_save :accept_notes, if: :accepted?
  after_save :update_job


  def name
    if problem.name || (not problem.name.blank?)
      name = problem.name
    else
      name = "#{problem.homework.number}.#{problem.number}"
    end

    name = "Тест, " + name if problem.homework.test?

    name
  end



  private
    def accept_notes
      self.notes.each{ |note| note.update fixed: true }
    end

    def update_job
      @job = self.job
      @job.update(done: @job.tasks.select{|x| x.status != "accepted"}.empty?)
      if @job.done?
        if @job.assignment.awards.count < 3 && @job.assignment.assignment_type != "test"
          @job.awards.create(rank: @job.assignment.awards.count + 1)
        end
        assignment = @job.assignment
        if assignment.jobs.where(done: false).empty?
          assignment.update(done: true)
        end
      else
        @job.assignment.update(done: false)
        if @job.awards.count > 0
          @job.awards.first.destroy
        end
      end
    end
end


