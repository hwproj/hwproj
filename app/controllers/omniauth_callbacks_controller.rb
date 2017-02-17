class OmniauthCallbackController < Devise::OmniauthCallbackController 
  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect root_path, event: :authentication
      set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
    else
      redirect_to root_path, flash: { error: 'Authentication failed!' }
    end
  end
end
