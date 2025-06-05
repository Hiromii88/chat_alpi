Rails.application.routes.draw do
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  get "mountains/index"
  get "mountains/show"
  root "top#index"

  get 'chatbots/show', to: 'chatbots#show', as: 'chatbots_show'

  resources :chatbots do
    collection do
      get 'generate_text'
    end
  end

  post 'select_character', to: 'characters#select', as: 'select_character'

  resources :mountains do
    resource :image, only: %i[destroy], module: 'mountains'
  end

  resources :users, only: %i[new create edit update destroy]

  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
