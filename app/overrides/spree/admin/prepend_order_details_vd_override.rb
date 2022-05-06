# insert_before :order_details_subtotal, :partial => "shared/order_details_volume_discount"

Deface::Override.new(
  virtual_path: 'spree/checkout/_summary',
  name: 'prepend_order_details_subtotal',
  insert_before: "erb[silent]:contains('if order.passed_checkout_step?')",
  partial: 'spree/shared/order_details_volume_discount'
)
