Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :slides do
      collection do
        post :update_positions
      end
    end

    resources :slide_locations
  end

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      get 'slider/:name', to: 'slide_locations#show'
    end
  end
end
