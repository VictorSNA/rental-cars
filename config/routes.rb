Rails.application.routes.draw do
  root to: 'home#index'
  resources :manufacturers
  resources :subsidiaries
  resources :car_categories
  resources :car_models, only: [:index, :show, :new, :create, :edit, :update]
end
