Deface::Override.new(
  virtual_path: 'spree/products/_cart_form',
  name: 'add_discounted_price_in_cart_form',
  replace: 'div#product-price div',
  text: '<div>
          <strike><span class="price selling" itemprop="price">
            <%= display_price(@product) if @product.on_discount? %>
          </span></strike>

          <span class="lead price selling" itemprop="price">
            <%= @product.display_discount_price %>
          </span>
          <span itemprop="priceCurrency" content="<%= @product.currency %>"></span>
        </div>',
  original: '1e3af073d141becce1c4c2d734923386c7dc9b07'
)
