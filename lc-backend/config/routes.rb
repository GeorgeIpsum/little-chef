Rails.application.routes.draw do
  resources :recipes do
    resources :instructions
  end
end
