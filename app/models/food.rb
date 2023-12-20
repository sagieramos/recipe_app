class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods
  def foods
    RecipeFood.joins(:food).where(recipe_id: id)
      .select('foods.name, recipe_foods.quantity, foods.price')
  end
end
