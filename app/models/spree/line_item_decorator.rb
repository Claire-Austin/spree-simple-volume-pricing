module Spree
  module LineItemDecorator
    def self.prepended(base)
      base.before_save :check_update_volume_discount
    end

    def update_volume_discount(updated_order = nil)
      self.volume_discount = 0
      self.order = updated_order if updated_order

      self.price = variant.volume_prices_source.price if variant.uses_master_discount? && new_record?

      return if quantity < 1 || !variant.uses_volume_pricing?

      unless variant.requires_per_product_discount?
        starting_quantity = order.variants_starting_quantity(variant_id)

        volume_cost = variant.volume_prices_source.total_volume_cost(starting_quantity, quantity)
        self.volume_discount = volume_cost - (quantity * price)
      end
    end

    private

    def check_update_volume_discount
      update_volume_discount if price_changed? || quantity_changed?
    end

    Spree::LineItem.prepend self
  end
end
