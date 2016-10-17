# This decorator is created by keeping that in mind
# what is when a user may need or want a sale event on
# an SKU or a Variant level. Variant needs to reflect the
# same on admin dashboard for selection from dropdrown in
# edit and new view pages.
#

Spree::Variant.class_eval do

  delegate :active_sale_events_live_active, to: :product, prefix: true, allow_nil: true

  delegate_belongs_to :default_price, :discounted_price_including_vat_for

  has_many :active_sale_events, as: :eventable

  # variant.live_active_sale_event gets first active sale event which is live and active
  def live_active_sale_event
    get_sale_event(self)
  end

  def live?
    !self.live_active_sale_event.nil? || self.product.live?
  end

  def discount_price_if_sale_live(currency = nil)
    amount = (currency ? price_in(currency).amount : price)
    get_active_sale_event ? discount_price(get_active_sale_event) : amount
  end

  def display_discount_price
    Spree::Money.new(discount_price(get_sale_event))
  end

  def have_discount?
    get_active_sale_event.try(:discount).to_f > 0
  end

  private
    def discount_price(sale_event)
      sale_event ? (price - ((price * sale_discount(sale_event.id).to_f) / 100)) : price
    end

    def get_sale_event
      get_active_sale_event || product.active_sale_events.last
    end

    def get_active_sale_event
      product_active_sale_events_live_active.first
    end

    def sale_discount(sale_id)
      product.sale_products.find_by(active_sale_event_id: sale_id).try(:discount)
    end
end
