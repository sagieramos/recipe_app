class RecipeFoodsController < ApplicationController
  def new
    @user = current_user
    # check if I am receiving the recipe_id in the params
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.new
    @foods = Food.all
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.new(food_id: params[:food][:food_id], quantity: params[:quantity])
    if @recipe_food.save
      redirect_to recipe_path(@recipe), notice: 'Recipe food successfully created.'
    else
      render :new, alert: 'Recipe food not created.'
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = @recipe_food.recipe
    if @recipe_food.destroy
      redirect_to recipe_path(@recipe), notice: 'Recipe food successfully deleted.'
    else
      redirect_to recipe_path(@recipe), alert: 'Recipe food not deleted.'
    end
  end

  def edit
    @user = current_user
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = @recipe_food.recipe
    @foods = Food.all
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = @recipe_food.recipe
    if @recipe_food.update(recipe_food_params)
      redirect_to recipe_path(@recipe), notice: 'Recipe food successfully updated.'
    else
      redirect_to request.referrer, alert: 'Recipe food not updated.'
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end
