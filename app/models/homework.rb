class Homework < ActiveRecord::Base
  validates :term_id, presence: {message: 'Выберите группу.'}
  validates :assignment_type, presence: {message: 'Выберите тип работы.'}

  validates_associated :problems

  enum assignment_type: [ :homework, :test ]

  belongs_to :group
  belongs_to :term

  has_many :problems, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :tasks, through: :jobs
  has_many :awards, through: :jobs
  has_many :links, as: :parent, dependent: :destroy

  accepts_nested_attributes_for :problems, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true

  def type
    case assignment_type
    when "homework"
      "Домашняя работа"
    when "test"
      "Контрольная работа"
    end
  end
end
