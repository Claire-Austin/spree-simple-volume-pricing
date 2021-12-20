# insert_after :admin_variant_edit_form, :partial => "admin/variants/volume_prices"

Deface::Override.new(:virtual_path => 'spree/admin/variants/_form',
                     :name => 'add_variants_vp',
                     :insert_after => '[data-hook="variants"]',
                     :partial => 'spree/admin/variants/volume_prices'
)