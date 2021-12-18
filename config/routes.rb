Rails.application.routes.draw do
  root 'session#welcome_page'
  get 'session/login'
  get 'session/welcome_page'
  post 'session/create'
  get 'session/logout'
  resources :users
  resources :posts
  resources :games
end
