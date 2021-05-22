Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      # get '/merchants', to: "merchants#index"
      resources :merchants, only: [:index, :show] do
        get '/items', to: "merchant_and_items#show"
      end
    end
  end
end
