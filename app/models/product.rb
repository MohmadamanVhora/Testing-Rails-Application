class Product < ApplicationRecord
  belongs_to :user
  validates :product_name, presence: true
  validates :price, presence: true, numericality: true
  validates :description, presence: true, length: { minimum: 10, maximum: 500 }
end
