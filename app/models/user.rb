class User < ApplicationRecord
  include UserAuth

  enum gender: [:male, :female]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable
  devise :omniauthable, omniauth_providers: %i[facebook]

  has_one_attached :avatar
  has_many :providers, class_name: 'UserProvider', dependent: :destroy
  belongs_to :country
  belongs_to :city
  has_many :user_past_cities
  has_many :past_cities, through: :user_past_cities, source: :city
  has_many :answers, class_name: 'UserAnswer'
  has_many :events, class_name: 'UserEvent'

  has_many :user_skills
  has_many :skills, through: :user_skills, source: :life_skill

  has_many :achievements, class_name: 'UserAchievement'
end
