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
    tasks.select{ |x| x.status != "accepted" }.count 
  end

  def deadline_tasks
    tasks.select { |t| t.created_at > Time.now - 2.weeks && t.created_at < Time.now - 1.weeks }
  end

  def overdue_tasks
    tasks.select { |t| t.created_at < Time.now - 2.weeks }
  end
end
