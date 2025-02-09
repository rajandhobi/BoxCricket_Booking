Rails.application.routes.draw do
  # namespace :admin do
  #   get "slots/index"
  #   get "slots/new"
  #   get "slots/create"
  #   get "slots/edit"
  #   get "slots/update"
  #   get "slots/destroy"
  #   get "grounds/index"
  #   get "grounds/new"
  #   get "grounds/create"
  #   get "grounds/edit"
  #   get "grounds/update"
  #   get "grounds/destroy"
  #   get "branches/index"
  #   get "branches/new"
  #   get "branches/create"
  #   get "branches/edit"
  #   get "branches/update"
  #   get "branches/destroy"
  # end

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
      resources :slots, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    end
  end
  

  resources :bookings
  
  root "branches#index"
end