FactoryBot.define do
  factory :recipe_food do
    recipe
    food
    quantity { 1 }
  end
end
