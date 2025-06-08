Rails.application.routes.draw do
  # CSV取り込み用
  get '/import_mountains', to: 'mountains#import_csv'

  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"

  resources :mountains do
    resource :image, only: %i[destroy], module: 'mountains'
  end

  resources :users, only: %i[new create edit update destroy]

  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'chatbots/show', to: 'chatbots#show', as: 'chatbots_show'

  resources :chatbots do
    collection do
      get 'generate_text'
    end
  end

  post 'select_character', to: 'characters#select', as: 'select_character'

  root "top#index"

  get 'test_log', to: 'application#test_log'
end
