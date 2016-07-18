class Notification < ActiveRecord::Base
  belongs_to :task
  belongs_to :user

  enum event_type: [ :task_accepted, :task_accepted_partially, :added_comments, :new_submission ]

  def Notification.new_event(user:, task:, event_type:, event_time:)
    notification = Notification.where('user_id = :user AND task_id = :task AND event_type = :event_type', user: user, task: task, event_type: Notification.event_types[event_type]).last
    if (not notification.nil?) and (not notification.is_read)
      notification.update(last_event_time: event_time)
    else
      Notification.create(user: user, task: task, event_type: event_type, first_event_time: event_time, last_event_time: event_time)
    end
  end
  def Notification.make_read(user:, task:)
    Notification.where('user_id = :user AND task_id = :task', user: user, task: task).each {|notification| notification.update(is_read: true)}
  end
  def versions_count
    self.task.submissions.where(created_at: self.first_event_time..self.last_event_time).count
  end
  def comments_count
    self.task.notes.where(created_at: self.first_event_time..self.last_event_time).count
  end
  def new_comments_form
    count = self.comments_count
    if (count >= 11 and count <= 19) or count % 10 >= 5 or count % 10 == 0
      "новых замечаний"
    elsif count % 10 == 1
      "новое замечание"
    else
      "новых замечания"
    end
  end
  def new_versions_form
    count = self.versions_count
    if (count >= 11 and count <= 19) or count % 10 >= 5 or count % 10 == 0
      "новых версий"
    elsif count % 10 == 1
      "новую версию"
    else
      "новых версии"
    end
  end
  def Notification.comment_deleted(user:, task:)
    Notification.where('user_id = :user AND task_id = :task', user: user, task: task).each {|notification| notification.destroy if notification.comments_count == 0}
  end
end
