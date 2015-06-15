class Cart < ActiveRecord::Base
    has_many :line_items, dependent: :destroy
    
    def total_price
      line_items.to_a.sum { |line_item| line_item.total_price }
    end
    
    def add_product(product)
      line_item = LineItem.find_by!(cart: self, product: product)
      line_item.quantity += 1
      line_item
    rescue ActiveRecord::RecordNotFound
      line_item = line_items.build(product: product)
      line_item
    end
    
    def add_product_and_save(product) 
      line_item = add_product(product)
      line_item.save
      line_item
    end
    
    def remove_all_products
      line_items.each { |line_item| line_item.destroy }
      line_items.clear
    end
end
