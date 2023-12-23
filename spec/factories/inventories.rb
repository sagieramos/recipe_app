require 'faker'
FactoryBot.define do
  factory :inventory do
    name { Faker::Color.unique.color_name }
    user
  end
end
