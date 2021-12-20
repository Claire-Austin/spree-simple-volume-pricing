class AddColumToVolumePrice < ActiveRecord::Migration[6.0]
  def self.up
    add_column :spree_products, :variants_use_master_discount, :boolean, null: false, default: 0 unless column_exists?(:spree_products, :variants_use_master_discount)
    add_column :spree_variants, :progressive_volume_discount, :boolean, null: false, default: 0 unless column_exists?(:spree_variants, :progressive_volume_discount)
    add_column :spree_line_items, :volume_discount, :decimal, precision: 8, scale: 2, null: false, default: 0 unless column_exists?(:spree_line_items, :volume_discount)
  end

  def self.down
    remove_column :spree_products, :variants_use_master_discount, :boolean, null: false, default: 0 if column_exists?(:spree_products, :variants_use_master_discount)
    remove_column :spree_variants, :progressive_volume_discount, :boolean, null: false, default: 0 if column_exists?(:spree_variants, :progressive_volume_discount)
    remove_column :spree_line_items, :volume_discount, :decimal, precision: 8, scale: 2, null: false, default: 0 if column_exists?(:spree_line_items, :volume_discount)
  end
end
