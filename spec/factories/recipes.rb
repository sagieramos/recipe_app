FactoryBot.define do
  factory :recipe do
    name { 'test recipe' }
    description { 'test description' }
    preparation_time { 10 }
    cooking_time { 10 }
    public { true }
    user
  end
end
