Rails.application.routes.draw do
  devise_for :users, controllers: { tokens: 'users/tokens' }
  namespace :api do
    namespace :v1 do
      require 'sidekiq/web'
      mount Sidekiq::Web => '/sidekiq'
      mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

      resources :articles, only: %i[index show create update destroy] do
        scope module: 'articles' do
          resources :comments, only: %i[create index] do
            member do
              put :like
              put :dislike
            end
          end
          resources :versions, only: [:index, :show] do
            member do
              post :rollback
            end
          end
        end
      end

      resources :categories, only: [:index]
    end
  end
end
