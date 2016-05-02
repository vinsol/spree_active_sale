module Spree
  class SaleTaxon < Spree::Base
    belongs_to :active_sale_event, :class_name => 'Spree::ActiveSaleEvent'
    belongs_to :taxon, :class_name => 'Spree::Taxon'
  end
end
