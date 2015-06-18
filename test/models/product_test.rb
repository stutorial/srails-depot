require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  
  setup do
    @valid_title = "My amazing title"
    @valid_description = "My amazing description"
    @valid_image_url = "my_amazing_url.jpg"
    @valid_price = 10
    @ruby = products(:ruby)
    @product_not_included_in_cart = products(:product_not_included_in_cart)
    @empty_cart = carts(:cart_with_no_line_items)
  end

  test "a product with valid attributtes can be created" do
    product = Product.new(title: @valid_title, description: @valid_description, image_url: @valid_image_url, price: @valid_price)
    
    assert product.valid?
  end
  
  test "a product must have a title" do
    product = Product.new(title: nil, description: @valid_description, image_url: @valid_image_url, price: @valid_price)
    
    assert product.invalid?
    assert product.errors[:title].include?("can't be blank"), "title is blank"
  end
  
  test "a product must have a description" do
    product = Product.new(title: @valid_title, description: nil, image_url: @valid_image_url, price: @valid_price)
    
    assert product.invalid?
    assert product.errors[:description].include?("can't be blank"), "description is blank"
  end
  
  test "a product must have an image url" do
    product = Product.new(title: @valid_title, description: @valid_description, image_url: nil, price: @valid_price)
    
    assert product.invalid?
    assert product.errors[:image_url].include?("can't be blank"), "image_url is blank"
  end
  
  test "a product must have a price" do
    product = Product.new(title: @valid_title, description: @valid_description, image_url: @valid_image_url, price: nil)
    
    assert product.invalid?
    assert product.errors[:price].include?("can't be blank"), "price is blank"
  end
  
  test "a product price can not be negative" do
    product = Product.new(title: @valid_title, description: @valid_description, image_url: @valid_image_url, price: -1)
    
    assert product.invalid?
    assert product.errors[:price].include?("must be greater than or equal to 0.01"), "price is negative"
  end
  
  test "a produce price can not be zero" do
    product = Product.new(title: @valid_title, description: @valid_description, image_url: @valid_image_url, price: 0)
    
    assert product.invalid?
    assert product.errors[:price].include?("must be greater than or equal to 0.01"), "price is zero"
  end
  
  test "a product price can be positive" do
    product = Product.new(title: @valid_title, description: @valid_description, image_url: @valid_image_url, price: 1)

    assert product.valid?
  end
  
  test "a product image url must end with valid extension" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    
    ok.each do |extension|
      assert Product.new(
        title: @valid_title,
        description: @valid_description,
        image_url: extension,
        price: @valid_price).valid?, "#{extension} should be valid"
    end
    
    bad.each do |extension|
      assert Product.new(
        title: @valid_title,
        description: @valid_description,
        image_url: extension,
        price: @valid_price).invalid?, "#{extension} shouldn't be valid"
    end
  end
  
  test "a product title must be at least ten characters long" do
    product = Product.new(title: "title", description: @valid_description, image_url: @valid_image_url, price: @valid_price)
      
    assert product.invalid?
    assert product.errors[:title].include?("must have at least 10 characters"), "title is not at least ten characters long"
  end
  
  test "a product title must be unique" do
    product = Product.new(title: @ruby.title, description: @valid_description, image_url: @valid_image_url, price: @valid_price)
      
    assert product.invalid?
    assert product.errors[:title].include?("has already been taken"), "title is not unique"
  end
  
  test "a product which is not included in a cart can be deleted" do
    assert_difference("Product.count", -1) do
      @product_not_included_in_cart.destroy
    end
  end
  
  test "a product which is included in a cart can not be deleted" do
    @empty_cart.add_product_and_save @ruby
    
    assert_no_difference("Product.count") do
      @ruby.destroy
    end
    
    assert @ruby.errors[:base].include?("Line Items present"), "product is included in a cart"
  end
  
end
