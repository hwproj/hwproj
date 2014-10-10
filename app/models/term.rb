class Term < ActiveRecord::Base
  belongs_to :course

  has_many :students
  has_many :assignments, class_name: 'Homework'
end
