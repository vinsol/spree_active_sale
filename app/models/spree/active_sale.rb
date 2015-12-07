# ActiveSales
# Active sales represent an entity for a group of sale events at a time.
# For example: 'My Sale/Product name' sale, which can have many schedules in it.
#
module Spree
  class ActiveSale < Spree::Base
    extend FriendlyId
    has_many :active_sale_events, -> { where(:deleted_at => nil) }, :dependent => :destroy

    acts_as_list

    validates :name, :permalink, :presence => true
    friendly_id :name, use: :slugged, slug_column: :permalink
    validates :permalink, uniqueness: { allow_blank: true }
    default_scope { order(position: :asc) }

    accepts_nested_attributes_for :active_sale_events, :allow_destroy => true, :reject_if => lambda { |attrs| attrs.all? { |k, v| v.blank? } }

    def self.config(&block)
      yield(Spree::ActiveSaleConfig)
    end

    # override the delete method to set deleted_at value
    # instead of actually deleting the sale.
    def delete
      self.update_column(:deleted_at, Time.zone.now)
      active_sale_events.update_all(:deleted_at => Time.zone.now)
    end

    def to_param
      permalink.present? ? permalink : (permalink_was || name.to_s.to_url)
    end

    def events
      self.active_sale_events
    end
    alias :schedules :events
  end
end
