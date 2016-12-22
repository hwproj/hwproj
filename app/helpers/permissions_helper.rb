module PermissionsHelper
  class Permissions
    def self.has_edit_course_permissions?(user, course)
      return (not user.nil? and user.teacher? and user.courses.where(id: course.id).length != 0)
    end
  end
end
