Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :players do 
    resources :games, only: [:create, :update, :destroy]
    "games#join"
  end
  resources :games, except: [:create, :update, :destroy]
  # Defines the root path route ("/")
  # root "articles#index"
end
