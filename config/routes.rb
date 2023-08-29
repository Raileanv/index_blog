Rails.application.routes.draw do
  devise_for :users, controllers: { tokens: 'users/tokens' }

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
