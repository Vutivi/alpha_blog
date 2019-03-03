Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :articles
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :categories
  resources :relationships,       only: [:create, :destroy]

  post   'search',   to: 'search#index', as: 'search_articles'
  get    'pages',    to: 'pages#home'
  get    'sign_up',  to: 'users#new'
  get    'sign_in',  to: 'sessions#new'
  post   'sign_in',  to: 'sessions#create'
  delete 'sign_out', to: 'sessions#destroy'
  root   'pages#home'

end
