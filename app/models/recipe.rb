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
end
