Spree::LineItem.class_eval do
  def update_price
    self.price = variant.discounted_price_including_vat_for(tax_zone: tax_zone)
  end

  def update_price_from_modifier(currency, opts)
    if currency
      self.currency = currency
      self.price = variant.discount_price_if_sale_live(currency) +
        variant.price_modifier_amount_in(currency, opts)
    else
      self.price = variant.discount_price_if_sale_live +
        variant.price_modifier_amount(opts)
    end
  end

  def live?
    self.product.live?
  end
end
