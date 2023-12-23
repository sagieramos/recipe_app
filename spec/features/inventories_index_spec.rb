require 'rails_helper'

RSpec.describe 'Inventories index', type: :feature do
  describe 'Inventories list' do
    let(:user) { FactoryBot.create(:user) }
    let(:inventory) { FactoryBot.create(:inventory, user: user) }

    before(:each) do
      user
      inventory
      visit '/users/sign_in'
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
    end

    it 'should display a list of inventories created by the logged-in user' do
      expect(page).to have_content(inventory.name)
    end

    it 'should lead to inventory details' do
      click_link 'Show'
      expect(page).to have_content(inventory.name)
    end

    it 'should allow to delete it' do
      click_link 'Delete'
      expect(page).to have_content('Inventory successfully deleted.')
    end
  end
end
