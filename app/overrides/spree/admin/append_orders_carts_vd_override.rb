# insert_after :cart_items, :partial => "orders/cart_volume_discount"

Deface::Override.new(:virtual_path => 'spree/orders/edit',
                     :name => 'append_orders_carts_vd',
                     :insert_bottom => '[data-hook="cart_items"]',
                     :partial => 'spree/orders/cart_volume_discount'
)