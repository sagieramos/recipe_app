FactoryBot.define do
  factory :recipe do
    name { Faker::Food.unique.dish }
    description { Faker::Food.description }
    preparation_time { Faker::Number.between(from: 1, to: 60) }
    cooking_time { Faker::Number.between(from: 1, to: 60) }
    public { Faker::Boolean.boolean }
    user
  end
end
