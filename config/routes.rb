Rails.application.routes.draw do
  root to: 'logs#index'

  resources :teams
  resources :bats, except: :index
  resources :pits, except: :index
  resources :games, except: :new
  resources :competitors
  resources :logs do
    resources :games, only: :new

  end
end
