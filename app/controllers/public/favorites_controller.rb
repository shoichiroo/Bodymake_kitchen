class Public::FavoritesController < ApplicationController
  def index
    @recipes = Recipe.find(Favorite.group(:recipe_id).order("count(recipe_id) desc").pluck(:recipe_id))
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    favorite = Favorite.new
    favorite.customer_id = current_customer.id
    favorite.recipe_id = @recipe.id
    favorite.save
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    favorite = Favorite.find_by(customer_id: current_customer.id, recipe_id: @recipe.id)
    favorite.destroy
  end
end