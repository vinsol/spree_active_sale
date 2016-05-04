Deface::Override.new(
  virtual_path: 'spree/home/index',
  name: 'show_sales_on_index',
  replace: '[data-hook="homepage_products"]',
  text: '<div data-hook="homepage_sales">
            <%= render partial: "spree/shared/sale_events", locals: { sale_events: @sale_events } %>
        </div>'
)
