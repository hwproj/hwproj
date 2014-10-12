class Link < ActiveRecord::Base
  include AddProtocol

  before_save :add_protocol
  belongs_to :parent, polymorphic: true
end
