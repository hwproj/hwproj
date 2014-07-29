class Problem < ActiveRecord::Base
  validates :text, presence: true
  belongs_to :homework
  has_many :tasks, dependent: :destroy

  def name
      "#{homework.number}.#{number}"
    end  
end
