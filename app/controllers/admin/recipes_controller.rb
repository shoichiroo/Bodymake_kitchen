class Admin::RecipesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @recipes = Recipe.page(params[:page])
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
