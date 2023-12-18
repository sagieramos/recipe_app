json.extract! inventory, :id, :user_id, :food_id, :quantity, :created_at, :updated_at
json.url inventory_url(inventory, format: :json)
