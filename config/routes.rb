Rails.application.routes.draw do
  get "mountain_links/show"
  get    'login',  to: 'sessions#new',     as: 'login'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users, only: %i[new create edit update destroy]
  resources :mountains do
    resource :image, only: %i[destroy], module: 'mountains'
  end

  get 'chatbots/show', to: 'chatbots#show', as: 'chatbots_show'

  get 'mountains/:name', to: 'mountains#show_by_name', as: 'mountain_by_name'

  resources :chatbots do
    collection do
      get 'generate_text'
    end
  end

  post 'select_character', to: 'characters#select', as: 'select_character'

  root "top#index"
end
