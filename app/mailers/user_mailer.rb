class UserMailer < ActionMailer::Base
  default from: "no-reply@hwproj.herokuapp.com"

  def new_submission_notify(submission)
    teacher = submission.user.group.teacher
    @student = submission.user
    @task = submission.task
    mail(to: teacher.email, subject: 'Новое решение')
  end

  def task_accepted_notify(task)
    @task = task
    mail(to: task.user.email, subject: 'Задача принята')
  end

  def new_notes_notify(submission)
    @task = submission.task
    @notes = submission.notes
    mail(to: submission.user.email, subject: "Замечания к задаче #{@task.name}")
  end

  def new_student_notify(user)
    @group = user.group
    @student = user
    mail(to: @group.teacher.email, subject: "Новый студент")
  end
end
