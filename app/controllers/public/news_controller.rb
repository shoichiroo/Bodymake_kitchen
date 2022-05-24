class Public::NewsController < ApplicationController
  before_action :authenticate_customer!

  def index
    require "news-api"
    news = News.new(ENV["NEWS_API_KEY"])
    @news = news.get_everything(q: "%E3%83%80%E3%82%A4%E3%82%A8%E3%83%83%E3%83%88", sortBy: "publishedAt", domains: "allabout.co.jp, cookpad.com, getnews.jp, toyokeizai.net, diamond.jp, nlab.itmedia.co.jp, gendai.ismedia.jp, youpouch.com, curazy.com, prtimes.jp")
  end
end
