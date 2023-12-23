require 'rails_helper'

RSpec.describe Food, type: :model do
  describe 'associations' do
    it { should have_many(:recipe_foods).dependent(:destroy) }
    it { should have_many(:inventory_foods).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(250) }
    it { should validate_presence_of(:measurement_unit) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
  end
end
