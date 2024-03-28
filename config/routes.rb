Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  root "top#index"
  get '/', to: "top#index"
  get '/show', to: "top#show"
end
