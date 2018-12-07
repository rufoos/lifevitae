class User < ApplicationRecord
  include UserAuth
  include UserBuilder

  enum gender: [:male, :female]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable
  devise :omniauthable, omniauth_providers: %i[facebook]

  has_one_attached :avatar
  has_many :providers, class_name: 'UserProvider', dependent: :destroy
  # belongs_to :country
  # belongs_to :city
  # has_many :user_past_cities
  # has_many :past_cities, through: :user_past_cities, source: :city
  has_many :past_cities, class_name: 'UserPastCity'
  has_many :answers, class_name: 'UserAnswer'

  has_many :my_events, class_name: 'LifeEvent'
  has_many :events, class_name: 'UserEvent'

  has_many :my_skills, class_name: 'LifeSkill'
  has_many :skills, class_name: 'UserSkill'

  has_many :achievements, class_name: 'UserAchievement'
end
