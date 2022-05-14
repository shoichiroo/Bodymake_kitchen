class Public::RecipesController < ApplicationController
  def index
    @recipes = Recipe.all.order(created_at: :desc)
    @categories = Category.all
    @favorite_recipes = Recipe.find(Favorite.group(:recipe_id).order("count(recipe_id) desc").limit(4).pluck(:recipe_id))
    @view_count_recipes = Recipe.find(ViewCount.group(:recipe_id).order("count(recipe_id) desc").limit(4).pluck(:recipe_id))
    @star_recipes = Recipe.left_joins(:reviews).distinct.sort_by do |recipe|
                      if recipe.reviews.present?
                        recipe.reviews.map(&:star).sum
                      else
                        0
                      end
                    end.reverse.first(4)
  end

  def new
    @recipe = Recipe.new
    @categories = Category.all
  end

  def create
    recipe = Recipe.new(recipe_params)
    recipe.customer_id = current_customer.id
    recipe.save
    redirect_to recipe_path(recipe)
  end

  def show
    @recipe = Recipe.find(params[:id])
    unless ViewCount.find_by(customer_id: current_customer.id, recipe_id: @recipe.id)
      current_customer.view_counts.create(recipe_id: @recipe.id)
    end
    @review = Review.new
    @reviews = @recipe.reviews
    @procedures = @recipe.procedures
    @foods = @recipe.foods
    @customer = @recipe.customer
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @categories = Category.all
  end

  def update
    recipe = Recipe.find(params[:id])
    recipe.update(recipe_params)
    redirect_to recipe_path(recipe)
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to root_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:image, :name, :description, :calorie, :protein, :fat, :carbo, :category_id)
  end
end
