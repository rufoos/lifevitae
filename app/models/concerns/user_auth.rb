module UserAuth
  extend ActiveSupport::Concern

  TEMP_EMAIL_TEMPLATE = '%s.%s@lifevitae.com'

  class_methods do
    def authorize_by_oauth(oauth)
      user_email = oauth.info.email.present? ? oauth.info.email : self.oauth_temp_email(oauth)
      if User.exists?(email: user_email)
        oauth_provider = UserProvider.where(provider: oauth.provider, uid: oauth.uid).includes(:user).first
        if oauth_provider
          oauth_provider.update_by_oauth!(oauth)
          oauth_provider.user
        else
          user = User.find_by(email: user_email)
          user.providers.build(oauth_provider_params(oauth))
          user.save ? user : nil
        end
      end
    end

    def registration_by_oauth(oauth)
      user = self.new(oauth_user_params(oauth))
      user.providers.build(oauth_provider_params(oauth))
      user.save ? user : nil
    end

    def oauth_temp_email(oauth)
      sprintf(TEMP_EMAIL_TEMPLATE, oauth.provider, oauth.uid)
    end

    def oauth_user_params(oauth)
      user_email = oauth.info.email.present? ? oauth.info.email : self.oauth_temp_email(oauth)
      {
        fullname: oauth.info.name,
        password: Devise.friendly_token[0, 20],
        email: user_email
      }
    end

    def oauth_provider_params(oauth)
      @oauth_provider_params ||= {
        provider: oauth.provider,
        token: oauth.credentials.token,
        expires_at: oauth.credentials.expires_at,
        uid: oauth.uid,
        avatar_link: oauth.info.image
      }
      @oauth_provider_params.merge!(username: oauth.info.name) if oauth.info.name.present?
    end
  end

  def oauth_sign_in(oauth)
    provider = providers.find_by(provider: oauth.provider)
    provider.update_attributes(username: oauth.info.name) if oauth.info.name.present?

    self.email = oauth.info.email if oauth.info.email.present?
  end
end
