Rails.application.routes.draw do
  root "expenses#index"

  resources :expenses, only: [ :index, :new, :create ] do
    collection do
      get :all
    end
  end

  # Income routes (using same controller since they share the same model)
  get "/income/new", to: "expenses#new", defaults: { type: "income" }, as: :new_income
  get "/all_transactions", to: "expenses#all", as: :all_transactions

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
