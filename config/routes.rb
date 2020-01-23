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
    get 'begin', on: :member
    post 'begin', on: :member, to: 'rentals#confirm_begin'
  end
  resources :cars, only: [:index, :new, :create, :show]

  namespace 'api' do
    namespace 'v1' do
      resources :cars, only: [:index, :show, :create]
    end
  end
end
