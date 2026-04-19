class ApplicationController < ActionController::Base
  include Authentication
  allow_browser versions: :modern

  helper_method :current_user

  private

  def after_authentication_url
    user_path(Current.user)
  end

  def after_logout_url
    root_path
  end

  def current_user
    Current.user
  end
end

