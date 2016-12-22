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

  def idTypeOfSubmissionInEnum(type)
    case (type)
    when "Shift+Enter"
      return 0;
    when "Ctrl+Enter"
      return 1;
    when "Enter"
      return 2;
    end
  end
end
