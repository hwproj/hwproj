class Notification < ActiveRecord::Base
  belongs_to :submission
  belongs_to :task
  belongs_to :user

  enum event_type: [ :task_accepted, :task_accepted_partially, :added_comments, :new_submission ]
end
