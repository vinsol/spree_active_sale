Spree::Price.class_eval do

  delegate :discount_price_if_sale_live, to: :variant

  def discounted_price_including_vat_for(options)
    options = options.merge(tax_category: variant.tax_category)
    gross_amount(discount_price_if_sale_live, options)
  end
end
