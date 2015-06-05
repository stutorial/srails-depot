require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  test "product with valid attributtes can be created" do
    product = Product.new(title: "My title", description: "My description", image_url: "image_url.jpg", price: 10)
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
    product = Product.new(title: "My title", description: "My description", image_url: "image_url.jpg", price: -1)
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
      assert Product.new(title: "My title", description: "My description", image_url: extension, price: 10).valid?, "#{extension} should be valid"
    end
    bad.each do |extension|
      assert Product.new(title: "My title", description: "My description", image_url: extension, price: 10).invalid?, "#{extension} shouldn't be valid"
    end
  end
  
end
