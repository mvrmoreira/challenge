class Culinary < ApplicationRecord
  has_and_belongs_to_many :restaurants, dependent: :destroy
end
