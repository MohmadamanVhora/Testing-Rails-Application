class ApplicationController < ActionController::Base
  before_action :authenticate_user
  skip_before_action :authenticate_user, if: :devise_controller?

  private
  def authenticate_user
    redirect_to new_user_session_path, flash: { alert: "You must be signed in" } if !current_user.present?
  end
end
