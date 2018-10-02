Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'foods', to: 'foods#index'
    end
  end
end
