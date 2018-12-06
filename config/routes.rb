Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users, controllers: {
    omniauth_callbacks: 'omniauth_callbacks',
    registrations: 'registrations'
  }

  devise_scope :users do
    get "users/auth/linkedin/callback" => "omniauth_callbacks#linkedin"
  end

  resource :current_user, only: [:show]
end
