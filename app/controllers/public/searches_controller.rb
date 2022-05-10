class Public::SearchesController < ApplicationController
  def search
    if params[:name].present? && params[:category].present?
      @name = params[:name]
      @recipe = Recipe.where("name LIKE ?", "%" + @name + "%")
      @recipes = @recipe.where(category_id: params[:category])
    elsif params[:name].present?
      @name = params[:name]
      @recipes = Recipe.where("name LIKE ?", "%" + @name + "%")
    elsif params[:category].present?
      @category = Category.find(params[:category])
      @recipes = @category.recipes
    else
      redirect_to root_path
    end
  end


end