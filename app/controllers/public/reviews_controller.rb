class Public::ReviewsController < ApplicationController
  before_action :authenticate_customer!

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
    if review.save
      redirect_to request.referer, notice: "レビューを投稿しました"
    else
      redirect_to request.referer
    end
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to request.referer, notice: "レビューを削除しました"
  end

  private

  def review_params
    params.require(:review).permit(:comment, :star)
  end
end
