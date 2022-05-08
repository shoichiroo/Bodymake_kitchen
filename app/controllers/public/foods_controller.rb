class Public::FoodsController < ApplicationController
  def new
    @food = Food.new(recipe_id: params[:recipe_id])
    @foods = Food.where(recipe_id: params[:recipe_id])
  end

  def create
    food = Food.new(food_params)
    food.save
    redirect_to request.referer
  end

  def destroy
    food = Food.find(params[:id])
    food.destroy
    redirect_to request.referer
  end

  private

  def food_params
    params.require(:food).permit(:name, :amount, :recipe_id)
  end
end
