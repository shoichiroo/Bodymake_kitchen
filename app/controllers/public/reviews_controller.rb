class Public::ReviewsController < ApplicationController
  def create
    recipe = Recipe.find(params[:recipe_id])
    review = Review.new(review_params)
    review.customer_id = current_customer.id
    review.recipe_id = recipe.id
    review.save
    redirect_to request.referer
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to request.referer
  end

  private

  def review_params
    params.require(:review).permit(:comment, :star)
  end
end
