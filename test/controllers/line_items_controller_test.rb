require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
  setup do
    @line_item = line_items(:one)
    @cart = carts(:cart_with_no_line_items)
    @ruby = products(:ruby)
  end

  test "should get index" do
    get :index
    
    assert_response :success
    assert_not_nil assigns(:line_items)
  end

  test "should get new" do
    get :new
    
    assert_response :success
  end

  test "should create line_item" do
    assert_difference('LineItem.count', 1) do
      post :create, product_id: products(:ruby).id
    end

    assert_redirected_to store_url
  end

  test "should show line_item" do
    get :show, id: @line_item
    
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @line_item
    
    assert_response :success
  end

  test "should update line_item" do
    patch :update, id: @line_item, add: 1, line_item: { cart_id: @line_item.cart_id, product_id: @line_item.product_id }
    
    assert_redirected_to store_url
  end

  test "should destroy line_item" do
    line_item = @cart.add_product_and_save @ruby
    
    assert_difference('LineItem.count', -1) do
      delete :destroy, id: line_item
    end

    assert_redirected_to store_url
  end
end
