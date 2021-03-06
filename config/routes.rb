Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root "welcome#index"
  # get '/' => "rails/welcome#index"

  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: "merchants/search#show"
      get '/merchants/most_items', to: "merchant_and_items#index"

      get '/items/find_all', to: "items/search#index"

      get '/revenue/merchants', to: "revenue/merchant_revenues#index"
      get '/revenue/merchants/:id', to: "revenue/merchant_revenues#show"

      get '/revenue/items', to: "revenue/item_revenues#index"
      resources :merchants, only: [:index, :show] do
        get '/items', to: "merchant_and_items#show"
      end

      resources :items do
        get '/merchant', to: "merchant_and_items#show"
      end
    end
  end
  get '*other', to: 'static#index'
end
