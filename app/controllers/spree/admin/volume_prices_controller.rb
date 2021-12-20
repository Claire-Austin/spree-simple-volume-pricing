module Spree
  module Admin
    class VolumePricesController < Spree::StoreController

      def destroy
        @volume_price = Spree::VolumePrice.find(params[:id])
        @volume_price.destroy
      end
    end
  end
end
