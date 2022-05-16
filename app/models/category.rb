class Category < ApplicationRecord
  has_many :recipes, dependent: :destroy

  validates :name, presence: true, length: {maximum: 20}
end
