module Spree::Admin::VariantsControllerDecorator
  def self.prepended(base)
    base.after_action :create_volume_prices, only: %i[create update]
  end

  def create_volume_prices
    return unless params[:variant][:volume_prices_attributes].present?

    params[:variant][:volume_prices_attributes].values.each do |volume|
      next if volume[:price].to_f.zero? || volume[:price].blank?

      volume_price = @variant.volume_prices.find_by(id: volume[:id])
      if volume_price.present?
        volume_price.update(volume_prices_attributes_params(volume))
      else
        volume_price = @variant.volume_prices.new(volume_prices_attributes_params(volume))
        volume_price.save!
      end
    end
  end

  private

  def volume_prices_attributes_params(attributes)
    {
      starting_quantity: attributes[:starting_quantity],
      price: attributes[:price]
    }
  end
end

::Spree::Admin::VariantsController.prepend Spree::Admin::VariantsControllerDecorator
