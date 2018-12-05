class UserProvider < ApplicationRecord
  belongs_to :user

  validates :provider, :uid, presence: true
  validates_uniqueness_of :uid, scope: [:provider, :user_id]

  before_validation do
    self.username = normalize_username(username) if username
  end

  def update_by_oauth!(oauth)
    update_data = {
      expires_at: oauth.credentials.expires_at,
      token: oauth.credentials.token,
      avatar_link: oauth.info.image
    }
    update_data.merge!(refresh_token: oauth.credentials.refresh_token) if oauth.credentials.refresh_token.present?

    update!(update_data)
  end

  private

  def normalize_username(username)
    username.gsub(/[^\p{Word}\p{Space}\p{Punct}\-\/\\|_]/, ' ').strip.gsub(/ {2,}/, ' ')
  end
end
