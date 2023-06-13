require "test_helper"

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = products(:product_one)
  end

  test "valid product" do
    assert @product.valid?
  end

  test "name should be present" do
    @product.product_name = ""
    assert_not @product.valid?, "Product should be invalid without a name"
  end

  test "price should be present" do
    @product.price = ""
    assert_not @product.valid?, "Product should be invalid without a price"
  end

  test "invalid product if price is not numeric" do
    @product.price = "abc"
    assert_not @product.valid?, "Product should be invalid with a non-numeric price"
  end
  
  test "description should be present" do
    @product.description = ""
    assert_not @product.valid?, "Product should be invalid without a description"
  end
  
  test "description length should be greater than 10" do
    @product.description = "a" * 9
    assert_not @product.valid?, "Product should be invalid with description less than 10 characters"
  end
  
  test "description length should be less than 500" do
    @product.description = "a" * 501
    assert_not @product.valid?, "Product should be invalid with description greater than 500 characters"
  end
end
