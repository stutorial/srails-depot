require 'test_helper'

class CartTest < ActiveSupport::TestCase

  setup do
    @ruby = products(:ruby)
    @coffescript = products(:coffescript)
    @cart = carts(:cart_with_no_line_items)
  end
  
  test "a product can be added to an empty cart" do
    assert_difference("@cart.line_items.count", 1) do
      @cart.add_product_and_save @ruby
    end
  end
  
  test "various products can be added to a cart" do
    assert_difference("@cart.line_items.count", 2) do
      @cart.add_product_and_save @ruby 
      @cart.add_product_and_save @coffescript
    end
  end
  
  test "the same product is added only once to a cart" do
    assert_difference("@cart.line_items.count", 1) do
      @cart.add_product_and_save @ruby
      @cart.add_product_and_save @ruby
    end
  end
  
  test "when two products are added and are the same, a cart create only one line with quantity 2" do
    @cart.add_product_and_save @ruby
    @cart.add_product_and_save @ruby
    
    ruby_line_items = @cart.line_items.select { |item| item.product == @ruby }.first
    
    assert_equal 2, ruby_line_items.quantity
  end
  
  test "an empty cart can be emptied" do
    @cart.remove_all_products
    
    assert_equal 0, @cart.line_items.count
  end
  
  test "a cart with products can be emptied" do
    @cart.add_product_and_save @ruby
    @cart.add_product_and_save @coffescript
    
    @cart.remove_all_products
    
    assert_equal 0, @cart.line_items.count
  end
  
  test "an empty cart can be deleted" do
    assert_difference("Cart.count", -1) do
      @cart.destroy
    end
  end
  
  test "a cart with products can be deleted" do
    @cart.add_product_and_save @ruby
    @cart.add_product_and_save @coffescript
    
    assert_difference("Cart.count", -1) do
      @cart.destroy
    end
  end
  
  test "when a cart is deleted, all of its line items are deleted too" do
    @cart.add_product_and_save @ruby
    @cart.add_product_and_save @coffescript

    assert_difference("LineItem.count", -2) do
      @cart.destroy
    end
  end
  
end
