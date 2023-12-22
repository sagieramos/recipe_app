require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:recipe_foods).dependent(:destroy) }
  end

  describe 'methods' do
    let(:user) { FactoryBot.create(:user) }
    let(:recipe) { FactoryBot.create(:recipe, user: user) }
    let(:food) { FactoryBot.create(:food) }
    let(:recipe_food) { FactoryBot.create(:recipe_food, recipe: recipe, food: food) }

    describe '#foods' do
      it 'should return all foods for a recipe' do
        expect(recipe.foods).to eq([recipe_food])
      end

      it 'should return the correct fields' do
        p recipe.foods.first, recipe.foods
        expect(recipe.foods.first.attributes.keys).to eq(%w[name quantity price])
      end
    end

    describe '#toggle_public' do
      it 'should toggle the public attribute' do
        expect(recipe.public).to eq(true)
        recipe.toggle_public
        expect(recipe.public).to eq(false)
      end
    end
  end
end
