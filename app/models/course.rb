class Course < ActiveRecord::Base
  belongs_to :teacher, class_name: 'User'

  has_many :terms, dependent: :destroy

  def create_term
    terms.last.update active: false if terms.any?
    terms.create(number: terms.count + 1)
  end
end
