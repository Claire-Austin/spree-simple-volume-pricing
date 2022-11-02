module Spree::Admin::VariantsControllerDecorator
  def self.prepended(base)
    base.after_action :create_volume_prices, only: %i[create update]
  end

  def create_volume_prices
    if params[:variant][:volume_prices_attributes].present?
      params[:variant][:volume_prices_attributes].each_value do |volume|
        next if volume[:price].to_f.zero? || volume[:price].blank?

        volume_price = @variant.volume_prices.find_by(id: volume[:id])

        if volume_price.present?
          @response = volume_price.update(volume_prices_attributes_params(volume))
        else
          volume_price = @variant.volume_prices.new(volume_prices_attributes_params(volume))
          @response = volume_price.save
        end

        @errors = volume_price.errors.full_messages.join(', ') if @response == false
      end
    end

    return unless @errors.present?

    flash.delete(:success)
    flash[:error] = @errors
  end

  private

  def volume_prices_attributes_params(attributes)
    {
      starting_quantity: attributes[:starting_quantity],
      price: attributes[:price],
      discount_price: attributes[:discount_price],
      start_date: attributes[:start_date],
      end_date: attributes[:end_date],
      active: attributes[:active]
    }
  end
end

::Spree::Admin::VariantsController.prepend Spree::Admin::VariantsControllerDecorator
