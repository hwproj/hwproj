class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



  include Github

  private
    def store_current_location
      store_location_for(:user, request.url)
    end
end
