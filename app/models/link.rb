class Link < ActiveRecord::Base
  before_save :add_protocol
  belongs_to :parent, polymorphic: true

  def add_protocol
    unless self.url[/\Ahttp:\/\//] || self.url[/\Ahttps:\/\//]
      self.url = "http://#{self.url}"
    end
  end
end
