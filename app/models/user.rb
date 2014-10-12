class User < ActiveRecord::Base
  validates :name, :surname, :gender, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum user_type: [ :student, :teacher ]
  enum gender: [:male, :female ]

  belongs_to :group

  # when user is teacher
  has_many :courses, foreign_key: "teacher_id" ,dependent: :destroy

  #when user is student
  has_many :subscriptions, class_name: 'Student', dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :tasks
  has_many :submissions, through: :tasks

  accepts_nested_attributes_for :tasks, :reject_if => :all_blank, :allow_destroy => true 

  before_create do
    self.name = self.name.strip
    self.surname = self.surname.strip
  end

  def tasks_left
    tasks.select{ |task| task.status != "accepted" }
  end

  def deadline_tasks
    tasks_left.select{ |task| task.created_at > Time.now - 2.weeks && task.created_at < Time.now - 1.weeks }
  end

  def overdue_tasks
    tasks_left.select{ |task| task.created_at < Time.now - 2.weeks }
  end

  def student_feed
    (tasks.select{|task| task.accepted? } + submissions.select{ |submission| submission.notes.any? }).sort_by{ |entry| entry.updated_at }.reverse
  end

  def full_name
    "#{name} #{surname}"
  end

  def has_tasks
    tasks.select{|task| task.status != "accepted"}.any?
  end
end

