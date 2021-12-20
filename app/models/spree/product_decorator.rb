module Spree
  module ProductDecorator
    def self.prepended(base)
      base.belongs_to :volume_prices_attributes
      base.belongs_to :progressive_volume_discount
    end

    def uses_volume_pricing?
      if variants_use_master_discount
        !master.volume_prices.empty?
      else
        !Spree::Product.where(id: id).joins(variants: :volume_prices).empty?
      end
    end

    def save_master
      return unless master && (master.changed? || master.new_record? || master.changed_for_autosave?)
      raise ActiveRecord::Rollback unless master.save
    end

    def all_variant_ids
      @all_variant_ids ||= Spree::Variant.where(product_id: id).map(&:id)
    end

    private

    def duplicate_extra(original)
      return unless original

      master.volume_prices = original.master.volume_prices.map do |vp|
        Spree::VolumePrice.new vp.attributes.slice('starting_quantity', 'price')
      end
    end

    Spree::Product.prepend self
  end
end
