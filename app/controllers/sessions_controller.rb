class SessionsController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
  end

  def create
    if (user = User.find_by(name: params[:name]))&.authenticate(params[:password]) 
      start_new_session_for user
      redirect_to after_authentication_url, notice: "Signed in successfully."
    else
     redirect_to "/session/new"
    end
  end

  def destroy
    terminate_session
    redirect_to after_logout_url, notice: "Logged out successfully."

  end
end
 