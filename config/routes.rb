Rails.application.routes.draw do
  resources :branches do
    resources :grounds
  end
  
  root "branches#index"
end