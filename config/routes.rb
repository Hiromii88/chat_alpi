Rails.application.routes.draw do
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

  resources :mountains, only: [:index, :show]
end
