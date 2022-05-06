class Public::RecipesController < ApplicationController
  def index
  end

  def new
    @recipe = Recipe.new
    @categories = Category.all
  end

  def create
  end
end
