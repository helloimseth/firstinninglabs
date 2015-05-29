Rails.application.routes.draw do
  resources :teams
  resources :bats, except: :index
  resources :games, except: :new
  resources :competitors
  resources :logs do
    resources :games, only: :new

  end
end
