Rails.application.routes.draw do
  root "branches#index"

  devise_for :users
  
  resources :grounds

  resources :branches do
    resources :grounds do
      resources :slots, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
        resource :booking, only: [:show, :create, :destroy] do
          get 'bookings', to: 'bookings#index', on: :collection  # Custom index route

          resources :payments, only: [:new, :create]  # Use resources here, not resource

        #  get 'bookings', to: 'bookings#index', on: :collection  # Custom index route
        end

      end
    end
  end
  
  

  # resources :bookings
  
  # root "branches#index"
end