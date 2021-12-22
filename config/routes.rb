Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    resources :comments
    root 'session#welcome_page'
    get 'session/login'
    get 'session/welcome_page'
    post 'session/create'
    get 'session/logout'
    resources :users
    resources :posts
    resources :games
  end
end
