class Review < ApplicationRecord
  belongs_to :customer
  belongs_to :recipe
  has_many :notifications, dependent: :destroy

  validates :star, presence: true, numericality: {less_than_or_equal_to: 5, greater_than_or_equal_to: 1}
  validates :comment, presence: true, length: {maximum: 200}


  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @review = Review.where("comment LIKE?","#{word}")
    elsif search == "forward_match"
      @review = Review.where("comment LIKE?","#{word}%")
    elsif search == "backward_match"
      @review = Review.where("comment LIKE?","%#{word}")
    elsif search == "partial_match"
      @review = Review.where("comment LIKE?","%#{word}%")
    else
      @review = Review.all
    end
  end
end
