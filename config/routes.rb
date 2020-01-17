Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :manufacturers
  resources :subsidiaries
  resources :car_categories
  resources :car_models, only: [:index, :show, :new, :create, :edit, :update]
  resources :clients, only: [:index, :show, :new, :create]
  resources :rentals, only: [:index, :new, :create, :show] do
    get 'search', on: :collection
  end
end
