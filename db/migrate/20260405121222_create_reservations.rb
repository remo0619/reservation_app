class CreateReservations < ActiveRecord::Migration[7.2]
  def change
    create_table :reservations do |t|
      t.date :checkin_date
      t.date :checkout_date
      t.integer :people
      t.integer :user_id
      t.integer :room_id

      t.timestamps
    end
  end
end
