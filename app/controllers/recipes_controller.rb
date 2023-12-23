class RecipesController < ApplicationController
  def index
    @user = current_user
    @recipes = @user.recipes
  end

  def show
    @user = current_user
    @recipe = Recipe.includes(recipe_foods: :food).find(params[:id])
    @recipe_foods = @recipe.recipe_foods
  end

  def new
    @user = current_user
    @recipe = @user.recipes.new
  end

  def create
    @user = current_user
    @recipe = @user.recipes.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      flash[:notice] = 'Recipe was successfully deleted.'
    else
      flash[:alert] = 'Recipe was not deleted.'
    end
    redirect_to request.referrer
  end

  def public_recipes
    @recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  def choose_inventory
    @recipe = Recipe.find(params[:id])
    @inventory = Inventory.find(params[:inventory_id])
    redirect_to shopping_list_path(recipe_id: @recipe.id, inventory_id: @inventory.id)
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.toggle_public
    redirect_to @recipe
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
