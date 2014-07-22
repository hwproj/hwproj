class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum user_type: [ :student, :teacher ]

  has_many :submissions
  has_many :tasks, through: :submissions

  accepts_nested_attributes_for :tasks, :reject_if => :all_blank, :allow_destroy => true 
end
