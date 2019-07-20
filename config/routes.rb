Rails.application.routes.draw do
  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html

  root to: 'welcome#index'

  resources :users, only: [:new, :create]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :landmarks, only: [:index, :show] do
    resources :recordings, only: [:new, :create]

  end

  resources :recordings, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :landmarks, only: [:index, :show]
    end
  end



end
