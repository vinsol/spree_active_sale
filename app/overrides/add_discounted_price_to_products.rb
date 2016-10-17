Deface::Override.new(
  virtual_path: 'spree/shared/_products',
  name: 'add_discounted_price_to_products',
  replace: '.panel-footer',
  text: '<div class="panel-footer text-center">
          <span itemprop="offers" itemscope itemtype="https://schema.org/Offer">
            <% if product.have_discount? %>
              <strike><spanitemprop="price"><%= display_price(product) %></span></strike>
              <span class="price selling lead" itemprop="price"><%= product.display_discount_price %></span>
            <% else %>
                <span class="price selling lead" itemprop="price"><%= display_price(product) %></span>
            <% end %>
          </span>
        </div>',
  original: '4668f768baf845e3ed816da2cf93204d5cc8fb35'
)
