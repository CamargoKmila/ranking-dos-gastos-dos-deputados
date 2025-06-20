Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :deputies, only: [:index] do
        resources :costs, only: [:index]
      end
    end
  end
end
