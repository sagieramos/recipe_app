require 'faker'

FactoryBot.define do
  factory :food do
    name { Faker::Food.unique.ingredient }
    price { Faker::Number.decimal(l_digits: 2) }
    measurement_unit { Faker::Food.metric_measurement }
  end
end
