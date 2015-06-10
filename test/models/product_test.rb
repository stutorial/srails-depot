require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  test "product with valid attributtes can be created" do
    product = Product.new(title: "My amazing title", description: "My description", image_url: "image_url.jpg", price: 10)
    assert product.valid?
  end
  
  test "product attributtes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end  
  
  test "product price must be positive" do
    product = Product.new(title: "My amazing title", description: "My description", image_url: "image_url.jpg", price: -1)
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]
    
    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]
    
    product.price = 0.001
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]
    
    product.price = 1
    assert product.valid?
  end
  
  test "product image url must end with valid extension" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    ok.each do |extension|
      assert Product.new(title: "My amazing title", description: "My description", image_url: extension, price: 10).valid?, "#{extension} should be valid"
    end
    bad.each do |extension|
      assert Product.new(title: "My amazing title", description: "My description", image_url: extension, price: 10).invalid?, "#{extension} shouldn't be valid"
    end
  end
  
  test "product ttile must be at least ten characters long" do
    product = Product.new(
      title: "title",
      description: "My description",
      image_url: "image.jpg",
      price: 10)
      
    assert product.invalid?
    assert_equal ["must have at least 10 characters"], product.errors[:title]
    
    product.title = "Ten characters long"
    assert product.valid?
  end
  
  test "product ttile must be unique" do
    product = Product.new(
      title: products(:ruby).title,
      description: "My description",
      image_url: "image.jpg",
      price: 10)
      
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end
  
  test "product which is not included in a cart can be deleted" do
    product = Product.create(
      title: "My amazing title",
      description: "My description",
      image_url: "image.jpg",
      price: 10)
    
    count = Product.count
    product.destroy
    
    assert_not_equal count, Product.count
  end
  
  test "product which is included in a cart can not be deleted" do
    product = Product.create(
      title: "My amazing title",
      description: "My description",
      image_url: "image.jpg",
      price: 10)
    cart = Cart.create
    LineItem.create(product: product, cart: cart)
    
    count = Product.count
    product.destroy
    
    assert_equal count, Product.count
    assert_equal ["Line Items present"], product.errors[:base]
  end
  
end
