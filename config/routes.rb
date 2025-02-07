Rails.application.routes.draw do
  devise_for :users
  
  resources :branches do
    resources :grounds
  end
  
  root "branches#index"
end