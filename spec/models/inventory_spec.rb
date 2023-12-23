require 'rails_helper'

RSpec.describe Inventory, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:inventory_foods).dependent(:destroy) }
  end

  describe 'methods' do
    let(:user) { FactoryBot.create(:user) }
    let(:food) { FactoryBot.create(:food) }
    let(:inventory) { FactoryBot.create(:inventory, user: user) }
    let(:inventory_food) { FactoryBot.create(:inventory_food, inventory: inventory, food: food) }

    before(:each) do
      user
      food
      inventory
      inventory_food
    end

    describe '#foods' do
      it 'should return all foods for an inventory' do
        expect(inventory.foods).to eq(inventory.inventory_foods.joins(:food))
      end

      it 'should return the correct fields' do
        expect(inventory.foods.last.attributes.keys).to eq(%w[name quantity measurement_unit id])
      end
    end
  end
end
