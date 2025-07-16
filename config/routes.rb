Rails.application.routes.draw do

  get    'login',  to: 'sessions#new',     as: 'login'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users, only: %i[new create edit show update destroy] do
    member do
      get :edit_cover_image
      patch :update_cover_image
    end
  end

  resources :password_resets, only: %i[new create edit update]

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

  resources :reports do
    resources :favorites, only: %i[create destroy]
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

end
