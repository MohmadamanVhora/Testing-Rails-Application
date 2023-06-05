module ProductsHelper
  def is_creator?(product)
    product.user == current_user
  end
end
