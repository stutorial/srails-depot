require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @ruby = products(:ruby)
    @valid_title = "My amazing title"
  end

  test "should get index" do
    get :index
    
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: { title: @valid_title, description: @ruby.description, image_url: @ruby.image_url, price: @ruby.price }
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @ruby
    
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ruby
    
    assert_response :success
  end

  test "should update product" do
    patch :update, id: @ruby, product: { title: @valid_title, description: @ruby.description, image_url: @ruby.image_url, price: @ruby.price }
    
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @ruby
    end

    assert_redirected_to products_path
  end
end
