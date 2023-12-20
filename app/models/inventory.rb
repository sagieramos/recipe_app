class Inventory < ApplicationRecord
  belongs_to :user
  has_many :inventory_foods, dependent: :destroy

  def foods
    InventoryFood.joins(:food).where(inventory_id: id)
      .select('foods.name, inventory_foods.quantity')
  end
end
