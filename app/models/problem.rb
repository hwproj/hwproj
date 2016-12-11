class Problem < ActiveRecord::Base
  before_create :set_number
  before_save :clean_name

  belongs_to :homework

  has_many :tasks, dependent: :destroy
  has_many :links, as: :parent, dependent: :destroy

  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true

  def displaying_name
    name ? name : number
  end

  def get_name
    if self.name && (not self.name.blank?)
      name = self.name
    else
      name = "#{self.homework.number}.#{self.number}"
    end
    name =  "Тест, " + name if self.homework.test?
    name
  end

  private
    def set_number
      self.number = self.homework.problems.count + 1
    end

    def clean_name
      self.name = nil if self.name.blank?
    end
end
