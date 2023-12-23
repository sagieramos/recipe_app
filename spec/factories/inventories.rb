require 'faker'
FactoryBot.define do
  factory :inventory do
    name { Faker::Color.color_name }
    user
  end
end
