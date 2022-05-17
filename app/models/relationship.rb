class Relationship < ApplicationRecord
  belongs_to :following, class_name: "Customer"
  belongs_to :follower, class_name: "Customer"
end
