class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!

  def index
    if params[:name].present? && params[:category].present?
      @name = params[:name]
      recipe = Recipe.where("name LIKE ?", "%" + @name + "%")
      @recipes = recipe.where(category_id: params[:category]).page(params[:page])
    elsif params[:name].present?
      @name = params[:name]
      @recipes = Recipe.where("name LIKE ?", "%" + @name + "%").page(params[:page])
    elsif params[:category].present?
      category = Category.find(params[:category])
      @recipes = category.recipes.page(params[:page])
    else
      redirect_to root_path
    end
  end

  def search_tag
    @tags = Tag.all
    @tag = Tag.find(params[:tag_id])
    @recipes = @tag.recipes.page(params[:page])
  end


end