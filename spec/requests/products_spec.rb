require 'rails_helper'

RSpec.describe 'Products', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }
  let(:product) { create_list(:product, 1, user:) }
  before { sign_in user }

  let(:valid_product) do
    {
      product_name: Faker::Name.name,
      price: Faker::Number.within(range: 1.0..999_999.0),
      description: Faker::Lorem.sentence,
      user:
    }
  end

  let(:invalid_product) do
    {
      name: Faker::Name.name,
      desc: Faker::Lorem.sentence
    }
  end

  describe 'GET /products' do
    it 'with user signed in should get index' do
      get products_path
      expect(response).to have_http_status(200)
    end

    it 'without user signed in should not get index' do
      sign_out user
      get products_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET /show' do
    it 'with user signed in should get show' do
      get product_path(product)
      expect(response).to have_http_status(200)
    end

    it 'without user signed in should not get show' do
      sign_out user
      get product_path(product)
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET /new' do
    it 'with user signed in should get new' do
      get new_product_path
      expect(response).to have_http_status(200)
    end

    it 'without user signed in should not get new' do
      sign_out user
      get new_product_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET /edit' do
    it 'with user signed in should get edit' do
      get edit_product_path(product)
      expect(response).to have_http_status(200)
    end

    it 'without user signed in should not get edit' do
      sign_out user
      get edit_product_path(product)
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'POST /create' do
    context 'with user signed in' do
      it 'with valid parameters should create product' do
        expect do
          post products_path, params: { product: valid_product }
        end.to change { Product.count }.by(1)
        expect(response).to redirect_to(product_path(Product.last))
      end

      it 'with invalid parameters should not create product' do
        expect do
          post products_path, params: { product: invalid_product }
        end.to change { Product.count }.by(0)
        expect(response).to have_http_status(422)
      end
    end

    context 'without user signed in' do
      it 'should not create product' do
        sign_out user
        expect do
          post products_path, params: { product: valid_product }
        end.to change { Product.count }.by(0)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with user signed in' do
      it 'with valid parameters should update product' do
        patch product_path(product), params: { product: { product_name: 'Mobile' } }
        expect(Product.last.product_name).to eq('Mobile')
        expect(response).to redirect_to(product_path(product))
      end

      it 'with invalid parameters should not update product' do
        patch product_path(product), params: { product: { name: 'Updated Product' } }
        expect(Product.last.product_name).not_to eq('Updated Product')
      end
    end

    context 'without user signed in' do
      it 'should not update product' do
        sign_out user
        patch product_path(product), params: { product: { product_name: 'Updated Product' } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'with user signed in should destroy product' do
      prod = Product.create valid_product
      expect do
        delete product_path(prod)
      end.to change { Product.count }.by(-1)
      expect(response).to redirect_to(products_path)
    end

    it 'without user signed in should not destroy product' do
      sign_out user
      prod = Product.create valid_product
      expect do
        delete product_path(prod)
      end.to change { Product.count }.by(0)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
