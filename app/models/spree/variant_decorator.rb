module Spree
  module VariantDecorator
    def self.prepended(base)
      # Relations
      base.has_many :volume_prices, dependent: :destroy, inverse_of: :variant

      # Attributes
      base.accepts_nested_attributes_for :volume_prices, reject_if: :blank_volume_price, allow_destroy: true

      # Attributes
      base.attr_accessor :volume_prices_attributes

      # Hooks
      base.after_create :copy_master_volume_prices
    end

    # Instance methods
    def volume_prices_source
      if !is_master && product.variants_use_master_discount
        product.master
      else
        self
      end
    end

    def uses_volume_pricing?
      volume_prices_source.volume_prices.present?
    end

    def uses_master_discount?
      product.variants_use_master_discount
    end

    def requires_per_product_discount?
      uses_master_discount? && product.variants.present?
    end

    def total_volume_cost(starting_quantity, quantity)
      batched_total_cost(starting_quantity, quantity)
    end

    def blank_volume_price(attributes)
      attributes['price'].blank?
    end

    private

    def copy_master_volume_prices
      return if product.master.blank?

      self.volume_prices = product.master.volume_prices.map do |vp|
        Spree::VolumePrice.new vp.attributes.slice('starting_quantity', 'price')
      end
    end

    def uniform_total_cost(starting_quantity, quantity)
      total_quantity = quantity + starting_quantity
      final_price = default_price = price

      volume_prices.each do |vp|
        break if vp.starting_quantity > total_quantity

        final_price = vp.price
      end

      quantity * final_price
    end

    def batched_total_cost(_starting_quantity, quantity)
      final_price = default_price = price
      if volume_prices.any?
        vp = volume_prices.where('spree_volume_prices.starting_quantity <= ?', quantity).last || volume_prices.first
        ((quantity / vp.starting_quantity).floor * vp.price) + (default_price * (quantity % vp.starting_quantity))
      else
        quantity * default_price
      end
    end

    Spree::Variant.prepend self
  end
end
