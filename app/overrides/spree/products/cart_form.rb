# insert_before :order_details_subtotal, :partial => "shared/order_details_volume_discount"

Deface::Override.new(
  virtual_path: 'spree/products/_cart_form',
  name: 'Add store ids hidden field in form',
  insert_before: 'div[class="add-to-cart-form-delivery"]',
  partial: 'spree/products/volume_prices'
)
