class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods

  def toggle_public
    update(public: false)
  end
end
