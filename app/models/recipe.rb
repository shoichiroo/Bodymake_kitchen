class Recipe < ApplicationRecord
  has_one_attached :image

  belongs_to :customer
  belongs_to :category
  has_many :foods, dependent: :destroy
  has_many :procedures, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :view_counts, dependent: :destroy

  # ユーザーがレシピをお気に入りしたか判定
  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end
end
