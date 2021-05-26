Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/merchants/find_all', to: "merchants/search#index"
      get '/merchants/find', to: "merchants/search#show"

      get '/items/find', to: 'items/search#show'
      get '/items/find_all', to: "items/search#index"

      get '/revenue/merchants', to: "revenue/merchant_revenues#index"
      resources :merchants, only: [:index, :show] do
        get '/items', to: "merchant_and_items#show"
      end

      resources :items do
        get '/merchant', to: "merchant_and_items#show"
      end
    end
  end
end
