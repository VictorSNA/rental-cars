class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.string :license_plate
      t.string :color
      t.references :car_model, foreign_key: true
      t.decimal :mileage

      t.timestamps
    end
  end
end
