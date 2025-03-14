require 'sidekiq/web'
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  mount Sidekiq::Web => '/sidekiq'

  resources :events, only: [:index, :show, :create, :update, :destroy]
  resources :bookings, only: [:create, :index]
  resources :tickets, only: [:create, :index, :update, :destroy]

  post '/login', to: 'authentication#login'
  post '/customers/signup', to: 'customers#create'
  post '/event_organizers/signup', to: 'event_organizers#create'

  # Defines the root path route ("/")
  # root "posts#index"
end
