class Problem < ActiveRecord::Base
  belongs_to :homework
  has_many :tasks, dependent: :destroy
end
