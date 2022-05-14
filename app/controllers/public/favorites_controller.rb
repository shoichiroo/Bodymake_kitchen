class Public::FavoritesController < ApplicationController
  def index
    recipes = Recipe.includes(:favorited_customers).sort {|a,b| b.favorited_customers.size <=> a.favorited_customers.size}
    @recipes = Kaminari.paginate_array(recipes).page(params[:page])
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
