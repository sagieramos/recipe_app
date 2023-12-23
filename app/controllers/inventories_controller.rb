class InventoriesController < ApplicationController
  def index
    @user = current_user
    @inventories = @user.inventories
  end

  def show
    @user = current_user
    @inventory = Inventory.includes(inventory_foods: :food).find(params[:id])
    @foods = @inventory.foods
  end

  def new
    @user = current_user
    @inventory = @user.inventories.new
  end

  def create
    @inventory = Inventory.new(inventory_params)
    @inventory.user = current_user
    if @inventory.save
      redirect_to @inventory, notice: 'Inventory was successfully created.'
    else
      render :new, alert: 'Inventory not created.'
    end
  end

  def destroy
    @inventory = Inventory.find(params[:id])
    if @inventory.destroy
      redirect_to inventories_path, notice: 'Inventory was successfully deleted.'
    else
      redirect_to inventories_path, alert: 'Inventory was not deleted.'
    end
  end

  # GET /shopping_list
  def shopping_list
    @recipe = Recipe.find(params[:recipe_id])
    @inventory = Inventory.find(params[:inventory_id])
    @shopping_list_foods = ShoppingListGenerator.generate_shopping_list(@inventory.id, @recipe.id)
  end

  private

  def inventory_params
    params.require(:inventory).permit(:name, :description)
  end
end
