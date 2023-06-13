FactoryBot.define do
  factory(:product) do
    product_name { Faker::Name.name }
    price { Faker::Number.within(range: 1.0..999_999.0) }
    description { Faker::Lorem.sentence }
  end
end
