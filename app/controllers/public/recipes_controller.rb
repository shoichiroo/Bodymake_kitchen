class Public::RecipesController < ApplicationController
  def index
    @recipes = Recipe.all.order(created_at: :desc)
  end

  def new
    @recipe = Recipe.new
    @categories = Category.all
  end

  def create
    recipe = Recipe.new(recipe_params)
    recipe.customer_id = current_customer.id
    recipe.save
    redirect_to new_recipe_food_path(recipe)
  end

  def show
  end

  private

  def recipe_params
    params.require(:recipe).permit(:image, :name, :description, :calorie, :protein, :fat, :carbo, :category_id)
  end
end
