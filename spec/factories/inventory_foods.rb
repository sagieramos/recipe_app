FactoryBot.define do
  factory :inventory_food do
    inventory
    food
    quantity { Faker::Number.between(from: 1, to: 10) }
  end
end
