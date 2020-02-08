class CreateRentalCancellations < ActiveRecord::Migration[5.2]
  def change
    create_table :rental_cancellations do |t|
      t.references :user, foreign_key: true
      t.date :date
      t.string :description
      t.references :rental, foreign_key: true
      t.references :car_rental, foreign_key: true

      t.timestamps
    end
  end
end
