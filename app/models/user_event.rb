class UserEvent < ApplicationRecord
  belongs_to :life_event
  belongs_to :user
end
