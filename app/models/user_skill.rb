class UserSkill < ApplicationRecord
  belongs_to :user
  belongs_to :life_skill
end
