# insert_before :admin_order_form_subtotal, :partial => "admin/orders/form_volume_discount"

Deface::Override.new(:virtual_path => 'spree/admin/orders/_form',
                     :name => 'admin_order_form_subtotal',
                     :insert_after => '[data-hook="order_details_total"]',
                     :partial => 'spree/admin/orders/form_volume_discount'
)