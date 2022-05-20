class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @range = params[:range]
    if @range == "customer"
      @customers = Customer.looks(params[:search], params[:word]).page(params[:page]).per(10)
    elsif @range == "recipe"
      @recipes = Recipe.looks(params[:search], params[:word]).page(params[:page])
    else
      @reviews = Review.looks(params[:search], params[:word]).page(params[:page]).per(10)
    end
  end
end
