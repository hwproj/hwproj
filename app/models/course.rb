class Course < ActiveRecord::Base
  belongs_to :teacher, class_name: 'User'

  has_many :terms, dependent: :destroy

  def create_term
    terms.create(number: terms.count + 1)
  end
end
