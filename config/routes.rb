Rails.application.routes.draw do
  get 'sessions/new'

  resources :users, only: %i[new create index]
  get '/sign_up', to: 'users#new', as: :sign_up

  resources :sessions, only: [:new, :create, :destroy]
  get '/log_in', to: 'sessions#new', as: :log_in
  delete '/log_out', to: 'sessions#destroy', as: :log_out

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/oauth/callback', to: 'data#create_session'
  get '/index', to: 'data#index', as: :datas
  get '/shutdown', to: 'data#shutdown'
  root to: 'users#index'
end
