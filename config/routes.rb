Rails.application.routes.draw do
  root "branches#index"

  # namespace :admin do
  #   resources :branches do
  #     resources :grounds, only: [:index, :new, :create]
  #   end
  #   resources :grounds, except: [:index, :new, :create] do
  #     resources :slots, only: [:index, :new, :create]
  #   end
  #   resources :slots, except: [:index, :new, :create]
  # end

  devise_for :users
  
  resources :grounds

  resources :branches do
    resources :grounds do
      resources :slots, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
        resource :booking, only: [:show, :create, :destroy]
      end
    end
  end
  
  

  # resources :bookings
  
  # root "branches#index"
end