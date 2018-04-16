class Restaurant < ApplicationRecord
  has_and_belongs_to_many :culinaries, dependent: :destroy
  has_many :reservations
  has_many :inventories
end
