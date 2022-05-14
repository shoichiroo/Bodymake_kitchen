class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @reviews = Review.page(params[:page]).per(10)
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to request.referer
  end
end
