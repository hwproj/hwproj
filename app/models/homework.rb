class Homework < ActiveRecord::Base
  belongs_to :group
  has_many :problems, dependent: :destroy
  validates_associated :problems
  validates :group_id, presence: true
  accepts_nested_attributes_for :problems, :reject_if => :all_blank, :allow_destroy => true   
end
