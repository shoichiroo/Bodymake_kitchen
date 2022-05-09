class Public::SearchesController < ApplicationController
  def search
    @name = params[:name]
    @recipes = Recipe.where("name LIKE ?", "%" + @name + "%")
  end
end
