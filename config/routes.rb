Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :manufacturers
  resources :subsidiaries
  resources :car_categories
  resources :car_models
  resources :clients, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :rentals, only: [:index, :new, :create, :show] do
    get 'search', on: :collection
    get 'begin', on: :member
    post 'begin', on: :member, to: 'rentals#confirm_begin'
    get 'cancel', on: :member
    post 'cancel', on: :member, to: 'rentals#confirm_cancel'
  end
  resources :cars, only: [:index, :new, :create, :show]

  namespace 'api' do
    namespace 'v1' do
      resources :cars, only: [:index, :show, :create, :update]
      resources :rentals, only: [:create]
      resources :car_models, only: [:destroy]
    end
  end
end
