require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:inventories) }
    it { should have_many(:recipes) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    let(:user_with_unvalid_password) { FactoryBot.build(:user, password: '123') }
    let(:user_with_unvalid_email) { FactoryBot.build(:user, email: 'test') }

    it 'should validate password complexity' do
      expect(user_with_unvalid_password.valid?).to eq(false)
    end
  end

  describe 'methods' do
    let(:user) { FactoryBot.create(:user) }
    let(:user_with_unvalid_password) { FactoryBot.build(:user, password: '123') }

    before(:each) do
      user
    end

    describe '#password_complexity' do
      it 'should unvalidate password with unmet comlexity' do
        expect(user_with_unvalid_password.valid?).to eq(false)
      end
      it 'should show error message for password with unmet comlexity' do
        user_with_unvalid_password.valid?
        expect(user_with_unvalid_password.errors.messages[:password].last).to eq('Complexity requirement not met.'
        .concat(' The password needs at least: one uppercase letter, ')
        .concat('and one lowercase letter, and one special character'))
      end

      it 'should validate password with met comlexity' do
        expect(user.valid?).to eq(true)
      end
    end
  end
end
