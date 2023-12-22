class InventoryFoodsController < ApplicationController
  def new
    @user = current_user
    # check if I am receiving the inventory_id in the params
    @inventory = Inventory.find(params[:inventory_id])
    @inventory_food = @inventory.inventory_foods.new
    @foods = Food.all
  end

  def create
    @inventory = Inventory.find(params[:inventory_id])
    @inventory_food = @inventory.inventory_foods.new(food_id: params[:food][:food_id], quantity: params[:quantity])
    if @inventory_food.save
      redirect_to inventory_path(@inventory), notice: 'Inventory food successfully created.'
    else
      render :new, alert: 'Inventory food not created.'
    end
  end

  def destroy
    @inventory_food = InventoryFood.find(params[:id])
    @inventory = @inventory_food.inventory
    if @inventory_food.destroy
      redirect_to inventory_path(@inventory), notice: 'Inventory food successfully deleted.'
    else
      redirect_to inventory_path(@inventory), alert: 'Inventory food not deleted.'
    end
  end

  private

  def inventory_food_params
    params.require(:inventory_foods).permit(:quantity, :food_id)
  end
end
