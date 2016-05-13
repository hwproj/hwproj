class Message < ActiveRecord::Base
  validates :text, presence: true

  belongs_to :task
  belongs_to :user
end
