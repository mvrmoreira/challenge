class Restaurant < ApplicationRecord
  has_and_belongs_to_many :culinaries, dependent: :destroy

  scope :by_culinary, -> (culinaryId) {
  	joins(:culinaries).where("culinary_id = ?", culinaryId)
  } 
end
