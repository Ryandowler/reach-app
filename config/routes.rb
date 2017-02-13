Rails.application.routes.draw do
  get 'books/payment_cancel'
  resources :user_profiles
  resources :charges
  resources :resources
  resources :examples
  devise_for :users
  resources :books
  root 'books#index'
end
