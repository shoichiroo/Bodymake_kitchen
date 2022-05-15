class Procedure < ApplicationRecord
  belongs_to :recipe

  validates :description, presence: true, length: {maximum: 60}
end
