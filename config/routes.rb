Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get '/logout', to: 'application#logout'

  resources :categories do
    resources :tasks do
      collection do
        get 'today' # For tasks due or scheduled today within a specific category
      end
    end
  end
  
  resources :tasks do
    collection do
      get 'today' # For tasks due or scheduled today across all categories
    end
  end

  root 'categories#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root 'tasks#today'
end