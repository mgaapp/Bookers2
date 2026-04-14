class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
   private

  def after_authentication_url
    new_session_path
  end
  
  def after_logout_url
    root_path
  end


 helper_method :current_user

  def current_user
    # sessionなどからユーザーIDを取得し、該当ユーザーを返すロジック
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
