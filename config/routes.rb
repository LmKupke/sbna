Rails.application.routes.draw do
  root "home#index"
  devise_for :users, controllers: { registrations: "registrations"}
  resources :users, only: [:show]
  namespace :admin do
    resources :users
  end
  namespace :api do
    resources :home, only: [:index]
    resources :events, only: [:index,:new,:edit,:update]
  end
  resources :events, only: [:index,:show, :new, :create, :edit, :update, :destroy]
  get 'calendar', controller: "events", action: "calendar"
  resources :events, only: [:show] do
    resources :attendees
  end
end
