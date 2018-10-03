Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :foods, only: [:index, :show, :create, :update, :destroy]
      resources :meals, only: [:index] do
        get 'foods', to: 'meals/foods#index'
      end
    end
  end
end
