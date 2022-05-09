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
    @recipe = Recipe.find(params[:id])
    @review = Review.new
    @reviews = @recipe.reviews
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @categories = Category.all
  end

  def update
    recipe = Recipe.find(params[:id])
    recipe.update(recipe_params)
    redirect_to recipe_path(recipe)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:image, :name, :description, :calorie, :protein, :fat, :carbo, :category_id)
  end
end
