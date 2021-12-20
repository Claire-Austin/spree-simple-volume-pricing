module Spree
  module ProductsHelperDecorator
    def display_prices_with_volume(variant)
      return unless variant.volume_prices.any?
      vp = variant.volume_prices.first
      raw Spree.t('product.price_for_qty', :price => Spree::Money.new(vp.price).to_html, :quantity => vp.starting_quantity.to_words)
    end
  end
end

::Spree::ProductsHelper.prepend Spree::ProductsHelperDecorator
