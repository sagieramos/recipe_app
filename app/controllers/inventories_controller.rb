class InventoriesController < ApplicationController
  def index
    @user = current_user
    @inventories = @user.inventories
  end

  def show
    @user = current_user
    @inventory = Inventory.includes(inventory_foods: :food).find(params[:id])
    @inventory_foods = @inventory.inventory_foods
  end

  def new
    @user = current_user
    @inventory = @user.inventories.new
  end

  def create
    @inventory = Inventory.new(inventory_params)
    @inventory.user = current_user
    if @inventory.save
      redirect_to @inventory, notice: 'Inventory successfully created.'
    else
      render :new, alert: 'Inventory not created.'
    end
  end

  def destroy
    @inventory = Inventory.find(params[:id])
    if @inventory.destroy
      redirect_to inventories_path, notice: 'Inventory successfully deleted.'
    else
      redirect_to inventories_path, alert: 'Inventory not deleted.'
    end
  end

  private

  def inventory_params
    params.require(:inventory).permit(:name)
  end
end
