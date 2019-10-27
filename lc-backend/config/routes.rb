Rails.application.routes.draw do
  resources :recipes do
    resources :instructions
  end
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
