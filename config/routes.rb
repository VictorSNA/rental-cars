Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :manufacturers
  resources :subsidiaries
  resources :car_categories
  resources :car_models
  resources :clients, only: %i[index show new create edit update destroy]
  resources :rentals, only: %i[index new create show] do
    get 'search', on: :collection
    get 'begin', on: :member
    post 'begin', on: :member, to: 'rentals#confirm_begin'
    get 'cancel', on: :member
    post 'cancel', on: :member, to: 'rentals#confirm_cancel'
  end
  resources :accessories, only: %i[index show new create]
  resources :cars, only: %i[index new create show]
  resources :reports, only: %i[index]

  namespace 'api' do
    namespace 'v1' do
      resources :cars, only: %i[index show create update]
      resources :rentals, only: %i[create]
      resources :car_models, only: %i[destroy]
    end
  end
end
