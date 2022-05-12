class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :favorite_recipes, through: :favorites, source: :recipe
  has_many :view_counts, dependent: :destroy

  def get_profile_image
    if profile_image.attached?
      profile_image
    else
      "no_image.jpg"
    end
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end

  def self.guest
    find_or_create_by!(name: "guestuser" ,email: "guest@example.com") do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "guestuser"
    end
  end
end
