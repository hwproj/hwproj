class Notification < ActiveRecord::Base
  belongs_to :task
  belongs_to :user

  enum event_type: [ :task_accepted, :task_accepted_partially, :added_comments, :new_submission, :added_message ]

  def Notification.new_event(user:, task:, event_type:, event_time:)
    notification = Notification.where(user: user, task: task, event_type: Notification.event_types[event_type]).last
    if notification and (not notification.is_read)
      notification.update(last_event_time: event_time)
    else
      Notification.create(user: user, task: task, event_type: event_type, first_event_time: event_time, last_event_time: event_time)
    end
  end

  def Notification.make_read(user:, task:)
    Notification.where(user: user, task: task).each {|notification| notification.update(is_read: true)}
  end

  def versions_count
    self.task.submissions.where(created_at: self.first_event_time..self.last_event_time).count
  end

  def comments_count
    self.task.notes.where(created_at: self.first_event_time..self.last_event_time).count
  end

  def messages_count
    self.task.messages.where(created_at: self.first_event_time..self.last_event_time).count
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
      "новая версия"
    else
      "новых версии"
    end
  end

  def new_messages_form
    count = self.messages_count
    if (count >= 11 and count <= 19) or count % 10 >= 5 or count % 10 == 0
      "новых сообщений"
    elsif count % 10 == 1
      "новое сообщение"
    else
      "новых сообщения"
    end
  end

  def Notification.comment_deleted(user:, task:)
    Notification.where(user: user, task: task).each {|notification| notification.destroy if notification.comments_count == 0}
  end

  def Notification.no_notifications_message(section:)
    case section
      when 'unread'
        'Непрочитанных оповещений нет'
      when 'show_all'
        'Нет новостей'
      when 'important'
        'Все задачи сдаются вовремя'
    end
  end
end
