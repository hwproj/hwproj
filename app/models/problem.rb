class Problem < ActiveRecord::Base
  belongs_to :homework
  has_many :tasks, dependent: :destroy

  def name
      "#{homework.number}.#{number}"
    end  
end
