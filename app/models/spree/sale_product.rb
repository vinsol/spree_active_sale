module Spree
  class SaleProduct < Spree::Base
    belongs_to :active_sale_event, :class_name => 'Spree::ActiveSaleEvent'
    belongs_to :product, class_name: 'Spree::Product'

    delegate :product_name, :to => :product
    delegate :sale_name, :to => :active_sale_event

    validates :active_sale_event_id, :product_id, :presence => true
    validates :active_sale_event_id, :uniqueness => { :scope => :product_id, :message => I18n.t('spree.active_sale.event.sale_product.already_exists') }

    delegate :discount, to: :active_sale_event

    def product_name
      product.try(:name)
    end

    def product_name=(name)
      self.product.name ||= name if name.present?
    end

    def product
      Spree::Product.unscoped { super }
    end

    def discount_price(amount = product.price)
      amount - ((amount * discount.to_f) / 100)
    end
  end
end
