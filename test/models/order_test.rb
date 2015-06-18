require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  setup do
    @valid_name = "My amazing name"
    @valid_address = "My amazing address"
    @valid_email = "my_amazing_email@email.com"
    @valid_pay_type = Order::PAYMENT_TYPES[0]
  end
  
  test "an order with valid attributtes can be created" do
    order = Order.new(name: @valid_name, address: @valid_address, email: @valid_email, pay_type: @valid_pay_type)
    
    assert order.valid?
  end
  
  test "an order must have a name" do
     order = Order.new(name: nil, address: @valid_address, email: @valid_email, pay_type: @valid_pay_type)
    
    assert order.invalid?
    assert order.errors[:name].include?("can't be blank"), "name is blank"
  end
  
  test "an order must have a address" do
     order = Order.new(name: @valid_name, address: nil, email: @valid_email, pay_type: @valid_pay_type)
    
    assert order.invalid?
    assert order.errors[:address].include?("can't be blank"), "address is blank"
  end
  
  test "an orde rmust have a email" do
     order = Order.new(name: @valid_name, address: @valid_address, email: nil, pay_type: @valid_pay_type)
    
    assert order.invalid?
    assert order.errors[:email].include?("can't be blank"), "email is blank"
  end
  
  test "an order must have a pay type" do
     order = Order.new(name: @valid_name, address: @valid_address, email: @valid_email, pay_type: nil)
    
    assert order.invalid?
    assert order.errors[:pay_type].include?("can't be blank"), "pay type is blank"
  end
  
  test "an order must have a valid pay type" do
    ok = Order::PAYMENT_TYPES
    bad = %w{ House 111 1a1a1a1 }
    
    ok.each do |type|
      assert Order.new(name: @valid_name, address: @valid_address, email: @valid_email, pay_type: type).valid?, "#{type} should be valid"
    end
    
    bad.each do |type|
      assert assert Order.new(name: @valid_name, address: @valid_address, email: @valid_email, pay_type: type).invalid?, "#{type} shouldn't be valid"
    end
  end
  
end
