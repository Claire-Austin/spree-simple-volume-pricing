module Spree
  module OrderUpdaterDecorator
    def update_item_total
      order.item_total = line_items.sum('price * quantity + volume_discount')
      update_order_total
    end

    Spree::OrderUpdater.prepend self
  end
end
