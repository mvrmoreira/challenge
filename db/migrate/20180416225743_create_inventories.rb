class CreateInventories < ActiveRecord::Migration[5.1]
  def change
    create_table :inventories do |t|
      t.integer :week_day
      t.integer :seats

      t.timestamps
    end
  end
end
