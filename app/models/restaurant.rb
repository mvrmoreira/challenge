class Restaurant < ApplicationRecord
  has_and_belongs_to_many :culinaries, dependent: :destroy
  has_many :reservations
  has_many :inventories

  scope :by_culinary, -> (culinaryId) {
  	joins(:culinaries).where("culinary_id = ?", culinaryId)
  }

  scope :available, -> (date, seats) {
  	joins(:inventories).where("week_day = ?", date.wday)
  	.joins("LEFT JOIN reservations ON reservations.restaurant_id = restaurants.id AND CAST(STRFTIME('%w', reservations.event_time) AS INTEGER) = ", date.wday.to_s)
  	.group("restaurants.id")
  	.having("(inventories.seats - IFNULL(SUM(reservations.seats), 0)) >= ?", seats.to_i)
  } 
end
