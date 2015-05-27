Rails.application.routes.draw do
  resources :teams
  resources :bats, except: :index
end
