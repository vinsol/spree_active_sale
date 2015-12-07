Deface::Override.new(
  virtual_path: 'spree/layouts/admin',
  name: 'active_sale_admin_sidebar_menu',
  insert_bottom: '#main-sidebar',
  partial: 'spree/admin/shared/active_sale_sidebar_menu'
)
