Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :articles

  get 'pages', to: 'pages#home'
  root 'pages#home'

end
