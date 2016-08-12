class InvitationsController < ApplicationController
  before_action :restrict_access_on_create, only: [ :new, :create ]

  def new
    @invitation = Invitation.new
    respond_to do |format|
      format.html { raise ActionController::RoutingError.new 'Not Found' }
      format.js
    end
  end

  def create
    @invitation = Invitation.new(invitation_params)
    invitation_token = SecureRandom.urlsafe_base64
    @invitation.digest = digest invitation_token

    if (@invitation.save)
      # Send mail
      UserMailer.invitation(invitation_token, @invitation.email).deliver

      @notice = "Приглашение отправлено."
    end
    respond_to do |format|
      format.js { render "new" }
    end
  end

  def edit
    @invitation = Invitation.find_by(email: params[:email], activated: false)

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
    @user = User.new(activation_params)
    @user.user_type = :teacher
    invitation = Invitation.find_by!(email: params[:email], activated: false)

    if @user.save
      invitation.update(activated: true)
      sign_in(:user, @user)
      redirect_to root_path
    else
      render_registration
    end
  end

private
  # Only teachers and administrators have permission to invite new users 
  def restrict_access_on_create
    authenticate_user! unless user_signed_in?
    raise ActionController::RoutingError.new 'Not Found' unless current_user.teacher? || current_user.admin?
  end

  # Params passed in create
  def invitation_params
    params.require(:invitation).permit(:email)
  end

  # Params passed in update
  def activation_params
    params.require(:user).permit(:name, :surname, :gender, :email, 
                                 :password, :password_confirmation)
  end

  def digest(string)
      cost = BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
  end

  # Horrible thing.
  def render_registration
    @url = invitation_path(params[:id], email: params[:email])
    @method = :put
    render "devise/registrations/new"
  end
end
