class User < ActiveRecord::Base
  validates :name, :surname, :gender, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum user_type: [ :student, :teacher ]
  enum gender: [:male, :female ]

  belongs_to :group
  has_many :notifications, dependent: :destroy
  has_many :messages, dependent: :destroy

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
    tasks.joins(student: :term).where(terms: {active: true}).where.not(status: Task.statuses[:accepted])
  end

  def deadline_tasks
    tasks_left.select{ |task| task.created_at > Time.now - 2.weeks && task.created_at < Time.now - 1.weeks && task.student.term.active? }
  end

  def overdue_tasks
    tasks_left.select{ |task| task.created_at < Time.now - 2.weeks && task.student.term.active? }
  end

  def full_name
    "#{name} #{surname}"
  end

  def has_tasks
    self.tasks_left.any?
  end

  def has_unread_notifications
    notifications.where(is_read: false).any?
  end

  def unread_notifications_count
    notifications.where(is_read: false).count
  end

  def public_email
    if additional_email.blank?
      public_email = email
    else
      public_email = additional_email
    end
  end

end

