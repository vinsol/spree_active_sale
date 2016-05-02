module Spree
  class SaleProperty < Spree::Base
    belongs_to :active_sale_event
    belongs_to :property

    validates :property, :presence => true
    validates :value, :length => { :maximum => 255 }
    default_scope { order(:position) }

    def property_name
      property.name if property
    end

    def property_name=(name)
      unless name.blank?
        unless property = Property.find_by_name(name)
          property = Property.create(:name => name, :presentation => name)
        end
        self.property = property
      end
    end
  end
end
