module Spree
  class SaleProduct < Spree::Base
    belongs_to :active_sale_event, :class_name => 'Spree::ActiveSaleEvent'
    belongs_to :product, -> { unscope(where: :deleted_at) }, class_name: 'Spree::Product'

    delegate :product_name, :to => :product
    delegate :sale_name, :to => :active_sale_event

    validates :active_sale_event_id, :product_id, :presence => true
    validates :active_sale_event_id, :uniqueness => { :scope => :product_id, :message => I18n.t('spree.active_sale.event.sale_product.already_exists') }

    def product_name
      product.try(:name)
    end

    def product_name=(name)
      self.product.name ||= name if name.present?
    end
  end
end
