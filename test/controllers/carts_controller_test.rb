require 'test_helper'

class CartsControllerTest < ActionController::TestCase
  setup do
    @cart = carts(:cart_with_no_line_items)
  end

  test "should get index" do
    get :index
    
    assert_response :success
    assert_not_nil assigns(:carts)
  end

  test "should get new" do
    get :new
    
    assert_response :success
  end

  test "should create cart" do
    assert_difference('Cart.count') do
      post :create, cart: {  }
    end

    assert_redirected_to cart_path(assigns(:cart))
  end

  test "should show cart" do
    get :show, id: @cart
    
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cart
    
    assert_response :success
  end

  test "should update cart" do
    patch :update, id: @cart, cart: {  }
    
    assert_redirected_to cart_path(assigns(:cart))
  end

  test "should destroy cart" do
    delete :destroy, id: @cart
    
    assert_equal 0, @cart.line_items.count
    assert_redirected_to store_url
  end
end
