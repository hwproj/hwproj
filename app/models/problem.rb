class Problem < ActiveRecord::Base
  before_create :set_number
  before_save :clean_name

  belongs_to :homework

  has_many :tasks, dependent: :destroy
  has_many :links, as: :parent, dependent: :destroy

  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true

  def get_displaying_name
    name ? name : number
  end

  private
    def set_number
      self.number = self.homework.problems.count + 1
    end

    def clean_name
      self.name = nil if self.name.blank?
    end
end
