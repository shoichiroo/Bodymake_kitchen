class Review < ApplicationRecord
  belongs_to :customer
  belongs_to :recipe
  has_many :notifications, dependent: :destroy

  validates :star, presence: true, numericality: {less_than_or_equal_to: 5, greater_than_or_equal_to: 1}
  validates :comment, presence: true, length: {maximum: 60}
end
