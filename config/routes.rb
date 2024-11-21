Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "/profile", to: "pages#profile"
  

  resources :shoes do

    collection do
      get 'filter'
      get 'my_list'
    end

    resources :bookings, only: [:new, :create, :show, :edit, :update] do
      resources :reviews, only: [:new, :create, :edit, :update, :destroy]
    end
  end

  resources :bookings, only: [:index]

  resources :wishlists, only: [:show] do
    post 'add_item', on: :collection
    delete 'remove_item', on: :collection
  end
  # Defines the root path route ("/")
  # root "posts#index"
  resources :bookings, only: [:index] do
    resources :reviews, only: [:index]
  end

end
