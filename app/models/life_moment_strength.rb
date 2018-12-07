class LifeMomentStrength < ApplicationRecord
  belongs_to :life_moment

  validates :name, presence: true
  validates :name, uniqueness: { scope: :life_moment_id }
end
