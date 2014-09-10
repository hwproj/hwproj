class User < ActiveRecord::Base
  validates :name, :surname, :gender, :group_id, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum user_type: [ :student, :teacher ]
  enum gender: [:male, :female ]

  belongs_to :group

  has_many :tasks
  has_many :submissions, through: :tasks

  accepts_nested_attributes_for :tasks, :reject_if => :all_blank, :allow_destroy => true 

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

