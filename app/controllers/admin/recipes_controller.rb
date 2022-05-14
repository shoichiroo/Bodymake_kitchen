class Admin::RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @procedures = @recipe.procedures
    @foods = @recipe.foods
    @customer = @recipe.customer
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to admin_recipes_path
  end
end
