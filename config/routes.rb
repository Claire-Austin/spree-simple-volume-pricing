Spree::Core::Engine.add_routes do
  # Add your extension routes here
  namespace :admin do
    resources :products do
      member do
        get :volume_prices
      end
    end

    delete '/volume_prices/:id', to: 'volume_prices#destroy', as: :volume_price
  end
end