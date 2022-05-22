class Contact < ApplicationRecord
  validates :name, length: {minimum: 2, maximum: 20}
  validates :content, presence: true
end
