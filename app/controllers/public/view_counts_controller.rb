class Public::ViewCountsController < ApplicationController
  def index
    @recipes = Recipe.find(ViewCount.group(:recipe_id).order("count(recipe_id) desc").pluck(:recipe_id))
  end
end
