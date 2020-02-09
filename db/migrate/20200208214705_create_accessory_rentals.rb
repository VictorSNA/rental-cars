class CreateAccessoryRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :accessory_rentals do |t|
      t.references :accessory, foreign_key: true
      t.references :rental, foreign_key: true

      t.timestamps
    end
  end
end
