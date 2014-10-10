class Homework < ActiveRecord::Base
  enum assignment_type: [ :homework, :test ]
  # belongs_to :group
  belongs_to :term

  has_many :problems, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :tasks, through: :jobs
  has_many :awards, through: :jobs
  has_many :links, as: :parent, dependent: :destroy
  
  validates_associated :problems
  # validates :group_id, presence: true
  accepts_nested_attributes_for :problems, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true
end
