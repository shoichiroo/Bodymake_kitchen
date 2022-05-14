class Public::ReviewsController < ApplicationController
  def index
    recipes = Recipe.left_joins(:reviews).distinct.sort_by do |recipe|
                if recipe.reviews.present?
                  recipe.reviews.map(&:star).sum
                else
                  0
                end
              end.reverse
    @recipes = Kaminari.paginate_array(recipes).page(params[:page])
  end

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
