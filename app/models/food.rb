class Food < ApplicationRecord
  belongs_to :recipe

  validates :name, presence: true, length: {maximum: 20}
  validates :amount, presence: true, length: {maximum: 20}
end
