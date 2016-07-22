class UserMailer < ActionMailer::Base
  default from: "no-reply@" + ENV['HOST']

  def new_submission_notify(submission)
    teacher = submission.student.term.course.teacher
    @student = submission.student
    @task = submission.task
    mail(to: teacher.email, subject: 'Новое решение')
  end

  def task_accepted_notify(task)
    @task = task
    mail(to: task.student.user.email, subject: 'Задача принята')
  end

  def new_notes_notify(submission)
    @task = submission.task
    @notes = submission.notes
    mail(to: submission.student.user.email, subject: "Замечания к задаче #{@task.name}")
  end

  def new_student_notify(student)
    @student = student
    @term = student.term
    mail(to: @term.course.teacher.email, subject: "Новый студент")
  end

end
