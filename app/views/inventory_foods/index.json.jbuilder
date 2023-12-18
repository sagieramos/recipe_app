# frozen_string_literal: true

json.array! @inventory_foods, partial: 'inventory_foods/inventory_food', as: :inventory_food
