class ChangeSaleEventDiscountType < ActiveRecord::Migration
  def up
    change_column :spree_active_sale_events, :discount, :decimal, precision: 8, scale: 2
  end

  def down
    change_column :spree_active_sale_events, :discount, :integer
  end
end
