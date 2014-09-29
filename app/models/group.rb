class Group < ActiveRecord::Base
  validates :number, :year, presence: true
  has_many :homeworks
  has_many :users
  has_many :awards, through: :homeworks
  has_many :problems, through: :homeworks
  belongs_to :teacher, class_name: "User"

  def name
    year.to_s + number.to_s
  end

  def tasks_left # До введения нескольких семестров
    Task.select{|x| x.status != "accepted"}.count
  end

end
