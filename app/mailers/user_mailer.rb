class UserMailer < ActionMailer::Base
  default from: "no-reply@hwproj.heroku.com"

  def new_submission_notify(submission)
  	teacher = submission.user.group.teacher
  	@student = submission.user
  	@task = submission.task
  	mail(to: teacher.email, subject: 'new submission')
  end
end
