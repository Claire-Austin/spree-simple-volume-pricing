class CreateSpreeVolumePrices < ActiveRecord::Migration[6.0]
  def change
    create_table :spree_volume_prices do |t|
      t.references :variant
      t.integer :starting_quantity, null: false
      t.decimal :price, precision: 8, scale: 2, null: false, default: 0.0

      t.timestamps
    end

    add_index :spree_volume_prices, [:variant_id, :starting_quantity], unique: true
  end
end

