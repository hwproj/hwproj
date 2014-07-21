class Homework < ActiveRecord::Base
    has_many :problems
    accepts_nested_attributes_for :problems, :reject_if => :all_blank, :allow_destroy => true   
end
