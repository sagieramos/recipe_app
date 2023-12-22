FactoryBot.define do
  factory :food do
    name { 'test food' }
    measurement_unit { 'test unit' }
    price { 10 }
    user
  end
end
