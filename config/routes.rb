Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'matches#index'

  resources :teams, only: [:index, :create, :destroy]
  resources :matches, only: [:index, :create]
end
