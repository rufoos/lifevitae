class UserAnswer < ApplicationRecord
  belongs_to :life_moment
  belongs_to :user
  has_many :answer_strengths, class_name: 'UserAnswerStrength'
  has_many :strengths, through: :answer_strengths, source: :life_moment_strength
end
