FactoryBot.define do
  factory :inventory_food do
    inventory
    food
    quantity { 1 }
  end
end
