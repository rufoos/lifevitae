class OmniauthCallbacksController < ApplicationController
  def facebook
    oauth = request.env["omniauth.auth"]

    if current_user
      redirect_to :root
    elsif (@user = User.authorize_by_oauth(oauth))
      @user.oauth_sign_in(oauth)
      sign_in_and_redirect(@user, event: :authentication)
    elsif (@user = User.registration_by_oauth(oauth))
      sign_in_and_redirect(@user, event: :authentication)
    else
      render template: "oauth/failure", layout: false
    end
  end
end
