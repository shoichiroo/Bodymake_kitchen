class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!

  def index
    if params[:name].present? && params[:category].present? && params[:calorie].present?
      @name = params[:name]
      recipe = Recipe.where("name LIKE ?", "%" + @name + "%")
      @recipes = recipe.where(category_id: params[:category], calorie: params_calorie).page(params[:page])
    elsif params[:name].present? && params[:category].present?
      @name = params[:name]
      recipe = Recipe.where("name LIKE ?", "%" + @name + "%")
      @recipes = recipe.where(category_id: params[:category]).page(params[:page])
    elsif params[:name].present? && params[:calorie].present?
      @name = params[:name]
      recipe = Recipe.where("name LIKE ?", "%" + @name + "%")
       @recipes = recipe.where(calorie: params_calorie).page(params[:page])
    elsif params[:category].present? && params[:calorie].present?
      @recipes = Recipe.where(category_id: params[:category], calorie: params_calorie).page(params[:page])
    elsif params[:name].present?
      @name = params[:name]
      @recipes = Recipe.where("name LIKE ?", "%" + @name + "%").page(params[:page])
    elsif params[:category].present?
      category = Category.find(params[:category])
      @recipes = category.recipes.page(params[:page])
    elsif params[:calorie].present?
      @recipes = Recipe.where(calorie: params_calorie).page(params[:page])
    else
      redirect_to root_path
    end
  end

  def search_tag
    @tags = Tag.all
    @tag = Tag.find(params[:tag_id])
    @recipes = @tag.recipes.page(params[:page])
  end


  private


  def params_calorie
    if params[:calorie] == "0~200"
      params[:calorie] = 0..200
    elsif params[:calorie] == "201~400"
      params[:calorie] = 201..400
    elsif params[:calorie] == "401~600"
      params[:calorie] = 401..600
    elsif params[:calorie] == "601~800"
      params[:calorie] = 601..800
    else
      params[:calorie] = 801..1000
    end
  end


end