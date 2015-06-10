class Cart < ActiveRecord::Base
    has_many :line_items, dependent: :destroy
    
    def add_product(product)
      line_item = LineItem.find_by!(cart: self, product: product)
      line_item.quantity += 1
      line_item
    rescue ActiveRecord::RecordNotFound
        line_item = line_items.build(product: product)
        line_item
    end
end
