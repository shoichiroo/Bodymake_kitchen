class Recipe < ApplicationRecord
  has_one_attached :image

  belongs_to :customer
  belongs_to :category
  has_many :foods, dependent: :destroy
  has_many :procedures, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_customers, through: :favorites, source: :customer
  has_many :reviews, dependent: :destroy
  has_many :view_counts, dependent: :destroy
  has_many :view_counted_customers, through: :view_counts, source: :customer
  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags
  has_many :notifications, dependent: :destroy

  validates :name, presence: true, length: {maximum: 20}
  validates :description, presence: true, length: {maximum: 60}
  validates :calorie, presence: true
  validates :protein, presence: true
  validates :fat, presence: true
  validates :carbo, presence: true
  validates :image, presence: true


  # ユーザーがレシピをお気に入りしたか判定
  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end


  def tags_save(tag_list)
    if self.tags != nil
      recipe_tags_records = RecipeTag.where(recipe_id: self.id)
      recipe_tags_records.destroy_all
    end

    tag_list.each do |tag|
      inspected_tag = Tag.where(tag_name: tag).first_or_create
      self.tags << inspected_tag
    end
  end


  # いいね通知機能
  def create_notification_favorite!(current_customer)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visiter_id = ? and visited_id = ? and recipe_id = ? and action = ? ", current_customer.id, customer_id, id, "favorite"])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_customer.active_notifications.new(
        recipe_id: id,
        visited_id: customer_id,
        action: "favorite"
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visiter_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  # コメント通知機能
  def create_notification_review!(current_customer, review_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Review.select(:customer_id).where(recipe_id: id).where.not(customer_id: current_customer.id).distinct
    temp_ids.each do |temp_id|
      save_notification_review!(current_customer, review_id, temp_id["customer_id"])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_review!(current_customer, review_id, customer_id) if temp_ids.blank?
  end

  def save_notification_review!(current_customer, review_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_customer.active_notifications.new(
      recipe_id: id,
      review_id: review_id,
      visited_id: visited_id,
      action: "review"
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end


  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @recipe = Recipe.where("name LIKE?","#{word}")
    elsif search == "forward_match"
      @recipe = Recipe.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @recipe = Recipe.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @recipe = Recipe.where("name LIKE?","%#{word}%")
    else
      @recipe = Recipe.all
    end
  end
end
