Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # get 'items/create'
  resources :topics, except: [:show]
  resources :topics, only: [:show] do
    get 'stats', to: "topics#stats"
  end
  resources :items, only: [:create]
  get 'item_success/:id', to: 'items#add_success', as: 'item_success'
  get 'item_mistake/:id', to: 'items#add_mistake', as: 'item_mistake'
  get 'item_hide/:id', to: 'items#toggle_hide', as: 'item_hide'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
