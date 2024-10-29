Rails.application.routes.draw do
  devise_for :users
  get 'items/index'
  root "items#index"

  resources :items
  resources :categories, only: [] do
    get 'items', to: 'items#category_index', as: 'items'
  end
end
