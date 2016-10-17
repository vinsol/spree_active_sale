  Spree::HomeController.class_eval do

    # List live, not hidden and active sales on home page
    def index
      @searcher = Spree::Config.searcher_class.new(params)
      @searcher.current_user = try_spree_current_user
      @searcher.current_currency = current_currency
      @sale_events = @searcher.retrieve_sales
      @taxonomies = Spree::Taxonomy.includes(root: :children)
      if @sale_events.present?
        respond_with(@sale_events)
      else
        @products = @searcher.retrieve_products.includes(:possible_promotions)
      end
    end
  end
