class UserAnswerStrength < ApplicationRecord
  belongs_to :user_answer
  belongs_to :life_moment_strength
end
