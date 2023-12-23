require 'rails_helper'

RSpec.describe InventoryFood, type: :model do
  let(:user) { User.new(name: 'chinese', email: 'example@email.com', password: 'abcdef') }
  @inventory = Inventory.new(user_id: @user)
  @food = Food.new(
    name: 'Rice',
    measurement_unit: 'grams',
    price: 5.99
  )
  subject do
    InventoryFood.new(
      quantity: 4,
      inventory_id: @inventory,
      food_id: @food
    )
  end

  before { subject.save }

  it 'should have an inventory' do
    expect(subject.inventory).to eq(@inventory)
  end

  it 'should have a food' do
    expect(subject.food).to eq(@food)
  end

  it 'should have a valid quantity' do
    subject.quantity = nil
    expect(subject).not_to be_valid
  end
end
