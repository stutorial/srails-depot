require 'test_helper'

class CartTest < ActiveSupport::TestCase

  setup do
    @ruby = products(:ruby)
    @coffescript = products(:coffescript)
    @cart = carts(:cart_with_no_line_items)
  end
  
  test "a product can be added to an empty cart" do
    line_item = @cart.add_product(@ruby)
    line_item.save
    
    assert_equal @ruby, line_item.product
    assert_equal @cart, line_item.cart
    assert_equal 1, @cart.line_items.count
  end
  
  test "a product can be added to a cart" do
    line_item1 = @cart.add_product(@ruby)
    line_item1.save
    
    line_item2 = @cart.add_product(@coffescript)
    line_item2.save
    
    assert_equal @ruby, line_item1.product
    assert_equal @cart, line_item1.cart
    assert_equal @coffescript, line_item2.product
    assert_equal @cart, line_item2.cart
    assert_equal 2, @cart.line_items.count
  end
  
  test "a cart can be deleted although it has line items" do
    line_item = @cart.add_product(@ruby)
    line_item.save
    
    line_item_count = LineItem.count
    cart_count = Cart.count
    
    @cart.destroy
    
    assert_not_equal cart_count, Cart.count
    assert_not_equal line_item_count, LineItem.count
  end
  
end
