class InventoryFoodsController < ApplicationController
  before_action :set_inventory_food, only: %i[show destroy]
  before_action :set_inventory

  # GET /inventory_foods/new
  def new
    @inventory_food = @inventory.inventory_foods.build
  end

  # POST /inventory_foods or /inventory_foods.json
  def create
    @food = Food.create!(name: params[:inventory_food][:name])
    @inventory_food = @inventory.inventory_foods.build(
      food_id: @food.id,
      quantity: params[:inventory_food][:quantity]
    )

    respond_to do |format|
      if @inventory_food.save
        format.html do
          redirect_to inventory_path(@inventory), notice: 'Inventory food was successfully created.'
        end
        format.json { render :show, status: :created, location: @inventory_food }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @inventory_food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_foods/1 or /inventory_foods/1.json
  def destroy
    @inventory_food.destroy!

    respond_to do |format|
      format.html { redirect_to inventory_foods_url, notice: 'Inventory food was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_inventory
    @inventory = Inventory.find(params[:inventory_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_inventory_food
    @inventory_food = InventoryFood.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def inventory_food_params
    params.require(:inventory_food).permit(:name, :quantity)
  end
end
