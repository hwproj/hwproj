class Course < ActiveRecord::Base
  belongs_to :teacher, class_name: 'User'

  has_many :terms, dependent: :destroy

  after_save :finish_terms, unless: :active?

  def self.all_hash
    {
      active: Course.where(active: true).order(:group_name),
      finished: Course.where(active: false).order(:group_name)
    }
  end

  private
    def finish_terms
      self.terms.each { |term| term.update active: false }
    end
end
