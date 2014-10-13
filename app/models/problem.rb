class Problem < ActiveRecord::Base
  validates :text, presence: true
  belongs_to :homework
  has_many :tasks, dependent: :destroy
  has_many :links, as: :parent, dependent: :destroy
  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true

  def name
    if homework.assignment_type == "test"
      "Тест #{homework.number}.#{number}"
    else
      "#{homework.number}.#{number}"
    end
  end
end
