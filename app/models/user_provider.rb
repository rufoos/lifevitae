class UserProvider < ApplicationRecord
  belongs_to :user

  validates :provider, :uid, presence: true
  validates_uniqueness_of :uid, scope: [:provider, :user_id]

  before_validation do
    self.username = normalize_username(username) if username
  end

  private

  def normalize_username(username)
    username.gsub(/[^\p{Word}\p{Space}\p{Punct}\-\/\\|_]/, ' ').strip.gsub(/ {2,}/, ' ')
  end
end
