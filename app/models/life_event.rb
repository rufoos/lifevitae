class LifeEvent < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id }

  scope :with_user, ->(user) { where('user_id IS NULL OR user_id = ?', user.id) }
end
