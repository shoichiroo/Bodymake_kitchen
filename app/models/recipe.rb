class Recipe < ApplicationRecord
  has_one_attached :image

  belongs_to :customer
  belongs_to :category
  has_many :foods, dependent: :destroy
  has_many :procedures, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :view_counts, dependent: :destroy

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
  image.variant(resize_to_limit: [width, height]).processed
  end

  # ユーザーがレシピをお気に入りしたか判定
  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end
end
