class Invitation < ActiveRecord::Base
  validates :email, presence: { message: "Не может быть пустым." }
  validate :email_availability, on: :create

private
  
  def email_availability
    if Invitation.find_by(email: email, activated: false)
      errors.add(:email, "Приглашение уже высылалось на этот адрес!")
    elsif User.teacher.find_by(email: email)
      errors.add(:email, "Преподаватель с таким адресом уже существует!")
    end
  end
end
