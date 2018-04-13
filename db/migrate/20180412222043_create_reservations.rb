class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.belongs_to :restaurant, foreign_key: true
      t.text :name
      t.text :email
      t.text :phone
      t.integer :seats
      t.datetime :event_time

      t.timestamps
    end
  end
end
