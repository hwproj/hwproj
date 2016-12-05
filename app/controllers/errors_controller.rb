class ErrorsController < ApplicationController
  include ActionDispatch

  def initialize
    @error = PublicExceptions.new('public')
  end

  def self.has_edit_course_permissions(user, course)
    return (not user.nil? and user.teacher? and user.courses.where(id: course.id).length != 0)
  end

  def security_error
    @error.call(env)
  end
end
