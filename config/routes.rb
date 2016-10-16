Rails.application.routes.draw do
  root "home#index"
  devise_for :users, controllers: { registrations: "registrations"}
  resources :users, only: [:show]

  namespace :api do
    resources :home, only: [:index]
    resources :events, only: [:index,:new,:edit,:update]
  end
  resources :events, only: [:index,:show]
end
