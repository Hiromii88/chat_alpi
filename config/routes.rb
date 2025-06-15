Rails.application.routes.draw do
  get    'login',  to: 'sessions#new',     as: 'login'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users, only: %i[new create edit update destroy]
  resources :mountains do
    resource :image, only: %i[destroy], module: 'mountains'
  end

  get 'chatbots/show', to: 'chatbots#show', as: 'chatbots_show'

  resources :chatbots do
    collection do
      get 'generate_text'
    end
  end

  post 'select_character', to: 'characters#select', as: 'select_character'

  root "top#index"
end
