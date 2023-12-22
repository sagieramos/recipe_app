# app/services/shopping_list_generator.rb

class ShoppingListGenerator
  def self.generate_shopping_list(inventory_id, recipe_id)
    RecipeFood.left_outer_joins(food: :inventory_foods)
      .where('inventory_foods.inventory_id = ? OR inventory_foods.id IS NULL', inventory_id)
      .where('inventory_foods.quantity IS NULL OR inventory_foods.quantity < recipe_foods.quantity')
      .where(recipe_id: recipe_id)
      .select(
        'CASE WHEN inventory_foods.quantity IS NULL THEN recipe_foods.quantity
                   ELSE recipe_foods.quantity - inventory_foods.quantity END AS quantity',
        'foods.name',
        'foods.id AS food_id',
        'foods.price',
        'foods.measurement_unit'
      )
      .order('foods.name')
      .includes(food: :inventory_foods)
  end
end
