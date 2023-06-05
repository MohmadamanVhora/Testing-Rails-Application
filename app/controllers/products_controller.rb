class ProductsController < ApplicationController
  before_action :find_product, only: %i[show edit update destroy check_user]
  before_action :check_user, only: %i[edit update destroy]

  def index
    @products = Product.all
  end

  def show; end

  def new
    @product = current_user.products.new
  end

  def create
    @product = current_user.products.new(product_params) 
    if @product.save
      redirect_to @product
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, status: :see_other
  end

  private
  def product_params
    params.require(:product).permit(:product_name, :description, :price)
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def check_user
    redirect_to products_path, alert: "You do not have permission to perform this action." unless @product.user == current_user
  end
end
