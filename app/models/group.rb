class Group < ActiveRecord::Base
	validates :number, :year, presence: true
	has_many :homeworks
	has_many :users
	has_many :problems, through: :homeworks

  def name
    year.to_s + number.to_s
  end

end
