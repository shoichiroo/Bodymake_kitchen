class Public::FoodsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_food, only: [:new]

  def new
    @foods = Food.where(recipe_id: params[:recipe_id])
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      redirect_to request.referer
    else
      @foods = Food.where(recipe_id: params[:recipe_id])
      render :new
    end
  end

  def destroy
    food = Food.find(params[:id])
    food.destroy
    redirect_to request.referer
  end

  def index
    redirect_to new_recipe_food_path(params[:recipe_id])
  end


  private


  def food_params
    params.require(:food).permit(:name, :amount, :recipe_id)
  end

  def ensure_food
    @food = Food.new(recipe_id: params[:recipe_id])
    if @food.recipe.customer != current_customer
      redirect_to recipe_path(params[:recipe_id])
    end
  end
end
