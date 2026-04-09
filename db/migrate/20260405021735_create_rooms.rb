class CreateRooms < ActiveRecord::Migration[7.2]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :introduction
      t.string :address
      t.string :image
      t.integer :price
      t.integer :user_id

      t.timestamps
    end
  end
end
