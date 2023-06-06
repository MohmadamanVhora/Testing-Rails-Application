require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  def setup
    get new_user_session_url
    sign_in users(:user_one)
    post user_session_url 
    @product = products(:product_one)
  end
  
  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should create product" do
    assert_difference "Product.count" do
      post products_url, params: { product: { product_name: "Testing product", price: 1999, description: "This is testing description." } }
    end
    assert_redirected_to product_url(Product.last)
  end

  test "should destroy product" do
    assert_difference "Product.count", -1 do
      delete product_url(@product)
    end
    assert_redirected_to products_url
  end

  test "should update product" do
    patch product_url(@product), params: { product: { product_name: "Updated testing product" } }
    assert_redirected_to product_url(@product)
    @product.reload
    assert_equal "Updated testing product", @product.product_name
  end
end
