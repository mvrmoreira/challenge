class CreateJoinTableRestaurantCulinary < ActiveRecord::Migration[5.1]
  def change
    create_join_table :restaurants, :culinaries do |t|
      # t.index [:restaurant_id, :culinary_id]
      # t.index [:culinary_id, :restaurant_id]
    end
  end
end
