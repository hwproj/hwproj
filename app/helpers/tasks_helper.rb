module TasksHelper
  def after_cancel_status(task)
    if task.notes.any?
      "accepted_partially"
    elsif task.submissions.any?
      "new_submission"
    else
      "not_submitted"
    end
  end
end