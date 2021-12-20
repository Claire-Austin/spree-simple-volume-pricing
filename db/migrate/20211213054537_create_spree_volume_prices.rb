class CreateSpreeVolumePrices < ActiveRecord::Migration[6.0]
  def change
    create_table :spree_volume_prices do |t|
      t.references :variant
      t.integer :starting_quantity
      t.decimal :price

      t.timestamps
    end

    add_index :spree_volume_prices, [:variant_id, :starting_quantity], unique: true
  end
end

