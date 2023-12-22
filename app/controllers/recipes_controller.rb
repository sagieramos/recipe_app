class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit destroy]
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
      flash[:notice] = 'Recipe deleted.'
    else
      flash[:alert] = 'Error deleting recipe.'
    end
    redirect_to request.referrer
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
