class InvitationsController < ApplicationController
  before_action :restrict_access_on_create, only: [ :new, :create ]

  def new
    @invitation = Invitation.new
    respond_to :js
  end

  def create
    @invitation = Invitation.new(invitation_params)
    invitation_token = SecureRandom.urlsafe_base64
    @invitation.digest = BCrypt::Password.create(invitation_token, cost: BCrypt::Engine.cost)

    if (@invitation.save)
      UserMailer.invitation(invitation_token, @invitation.email).deliver
      @notice = "Приглашение отправлено."
    end

    respond_to do |format|
      format.js { render "new" }
    end
  end

  def edit
    @invitation = Invitation.find_by(email: params[:email], active: true)

    unless (@invitation && BCrypt::Password.new(@invitation.digest).is_password?(params[:id]))
      raise ActionController::RoutingError.new 'Not Found'
    end

    if user_signed_in?
      current_user.update(user_type: :teacher) if current_user.email == params[:email]
      return redirect_to root_path
    end

    @user = User.new(email: params[:email])
    render_registration
  end

  def update
    @user = User.new(sign_up_params)
    @user.user_type = :teacher
    invitation = Invitation.find_by!(email: params[:email], active: true)

    if @user.save
      invitation.update(active: false)
      sign_in(:user, @user)
      redirect_to root_path
    else
      render_registration
    end
  end

private
  def restrict_access_on_create
    authenticate_user! unless user_signed_in?
    raise ActionController::RoutingError.new 'Not Found' unless current_user.teacher? || current_user.admin?
  end

  def invitation_params
    params.require(:invitation).permit(:email)
  end

  def sign_up_params
    params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation)
  end

  def render_registration
    @url = invitation_path(params[:id], email: params[:email])
    @method = :put
    render "devise/registrations/new"
  end
end
