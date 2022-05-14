class Public::ViewCountsController < ApplicationController
  def index
    recipes = Recipe.includes(:view_counted_customers).sort {|a,b| b.view_counted_customers.size <=> a.view_counted_customers.size}
    @recipes = Kaminari.paginate_array(recipes).page(params[:page])
    #@recipes = Recipe.find(ViewCount.group(:recipe_id).order("count(recipe_id) desc").pluck(:recipe_id))
  end
end
