module Spree
  module Admin
    module ProductsControllerDecorator
      def volume_prices
        load_object
      end
    end
  end
end

::Spree::Admin::ProductsController.prepend Spree::Admin::ProductsControllerDecorator
