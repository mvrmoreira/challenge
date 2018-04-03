class CreateCulinaries < ActiveRecord::Migration[5.1]
  def change
    create_table :culinaries do |t|
      t.string :name

      t.timestamps
    end
  end
end
