class User < ActiveRecord::Base
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


  def deadline_tasks
    tasks.select { |t| t.created_at > Time.now - 2.weeks && t.created_at < Time.now - 1.weeks }
  end

  def overdue_tasks
    tasks.select { |t| t.created_at < Time.now - 1.day }
  end
end
