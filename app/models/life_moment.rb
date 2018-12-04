class LifeMoment < ApplicationRecord
  has_many :strengths, class_name: 'LifeMomentStrength'
end
