require 'test_helper'

class CartTest < ActiveSupport::TestCase
  
  test "a cart can be deleted although it has line items" do
    product = products(:ruby)
    cart = carts(:cart_with_no_line_items)
    LineItem.create(product: product, cart: cart)
    
    line_item_count = LineItem.count
    cart_count = Cart.count
    
    cart.destroy
    
    assert_not_equal cart_count, Cart.count
    assert_not_equal line_item_count, LineItem.count
  end
end
