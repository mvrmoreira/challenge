class CreateInventories < ActiveRecord::Migration[5.1]
  def change
    create_table :inventories do |t|
      t.integer :week_day
      t.integer :seats
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
