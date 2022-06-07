class Public::RecipesController < ApplicationController
  before_action :authenticate_customer!, except: [:top]
  before_action :ensure_recipe, only: [:edit]

  def top
    @recipes = Recipe.page(params[:page]).order(created_at: :desc)
    @categories = Category.all
    @favorite_recipes = Recipe.includes(:favorited_customers).sort {|a,b| b.favorited_customers.size <=> a.favorited_customers.size}.first(4)
    @view_count_recipes = Recipe.includes(:view_counted_customers).sort {|a,b| b.view_counted_customers.size <=> a.view_counted_customers.size}.first(4)
    @star_recipes = Recipe.left_joins(:reviews).distinct.sort_by do |recipe|
                      if recipe.reviews.present?
                        recipe.reviews.map(&:star).sum
                      else
                        0
                      end
                    end.reverse.first(4)
    if Rails.env.development?
      @random_recipes = Recipe.order("RANDOM()").limit(3)
    else
      @random_recipes = Recipe.order("RAND()").limit(3)
    end
    require "news-api"
    news = News.new(ENV["NEWS_API_KEY"])
    @news = news.get_everything(q: "%E3%83%80%E3%82%A4%E3%82%A8%E3%83%83%E3%83%88", sortBy: "publishedAt", domains: "allabout.co.jp, cookpad.com, getnews.jp, toyokeizai.net, diamond.jp, nlab.itmedia.co.jp, gendai.ismedia.jp, youpouch.com, curazy.com, prtimes.jp", pageSize: 4)
  end

  def new
    @recipe = Recipe.new
    @categories = Category.all
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.customer_id = current_customer.id
    tag_list = params[:recipe][:tag_names].split("#")
    if @recipe.save
      @recipe.tags_save(tag_list)
      redirect_to recipe_path(@recipe), notice: "レシピを投稿しました"
    else
      @categories = Category.all
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    unless ViewCount.find_by(customer_id: current_customer.id, recipe_id: @recipe.id)
      current_customer.view_counts.create(recipe_id: @recipe.id)
    end
    @review = Review.new
    @review_nil = Review.find_by(recipe_id: @recipe.id, customer_id: current_customer.id).nil?
    @reviews = @recipe.reviews.page(params[:page]).per(5)
    @procedures = @recipe.procedures
    @foods = @recipe.foods
    @customer = @recipe.customer
    @tags = @recipe.tags
  end

  def edit
    @categories = Category.all
    @tag_list = @recipe.tags.pluck(:tag_name).join("#")
  end

  def update
    @recipe = Recipe.find(params[:id])
    tag_list = params[:recipe][:tag_names].split("#")
    if @recipe.update(recipe_params)
      @recipe.tags_save(tag_list)
      redirect_to recipe_path(@recipe), notice: "レシピを編集しました"
    else
      @categories = Category.all
      render :edit
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to root_path, notice: "レシピを削除しました"
  end

  def index
    redirect_to new_recipe_path
  end


  private


  def recipe_params
    params.require(:recipe).permit(:image, :name, :description, :calorie, :protein, :fat, :carbo, :category_id)
  end

  def ensure_recipe
    @recipe = Recipe.find(params[:id])
    if @recipe.customer != current_customer
      redirect_to root_path
    end
  end
end
