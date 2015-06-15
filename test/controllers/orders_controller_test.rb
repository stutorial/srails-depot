require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:order_with_no_line_items)
    @one = line_items(:one)
  end

  test "should get index" do
    get :index
    
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "requires item in cart" do
    get :new
    
    assert_redirected_to store_url
    assert_equal flash[:notice], "your cart is empty"
  end
  
  test "should get new" do
    session[:cart_id] = @one.cart_id

    get :new
    
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { address: @order.address, email: @order.email, name: @order.name, pay_type: @order.pay_type }
    end

    assert_redirected_to store_url
  end

  test "should show order" do
    get :show, id: @order
    
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order
    
    assert_response :success
  end

  test "should update order" do
    patch :update, id: @order, order: { address: @order.address, email: @order.email, name: @order.name, pay_type: @order.pay_type }
    
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end
