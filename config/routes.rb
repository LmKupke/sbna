Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root "home#index"
  devise_for :users, controllers: { registrations: "registrations"}
  resources :users, only: [:show]

  namespace :api do
    resources :attendees, only: [ :index, :create, :destroy]
    resources :events, only: [:index,:new,:edit,:update]
  end
  resources :events, only: [:index,:show, :new, :create, :edit, :update, :destroy]
  get 'calendar', controller: "events", action: "calendar"
  resources :events, only: [:show] do
    resources :attendees
    resources :guests
  end
  get "static_pages/board", as: "board", path: "board"
  get "static_pages/committees", as: "committee", path: "committees"
  get "static_pages/contact", as: "contact", path: "contact"
  get "static_pages/meeting_minutes", as: "meeting_minutes", path: "meeting_minutes"


end
