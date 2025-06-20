Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :deputies, only: [:index] do
        get :total_spending, on: :member
        get :biggest_expense, on: :member
        resources :costs, only: [:index]
      end
    end
  end
end
