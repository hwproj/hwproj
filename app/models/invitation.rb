class Invitation < ActiveRecord::Base
  validates :email, presence: { message: "Не может быть пустым." }
  validates_format_of :email,:with => Devise.email_regexp
  validate :email_availability, on: :create
  validates :digest, presence: true

private
  
  def email_availability
    if Invitation.find_by(email: email, active: true) || User.teacher.find_by(email: email)
      errors.add(:email, "Пользователь уже приглашён.")
    end
  end
end
