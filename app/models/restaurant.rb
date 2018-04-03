class Restaurant < ApplicationRecord
  has_and_belongs_to_many :culinaries, dependent: :destroy
end
