class CreateAccessories < ActiveRecord::Migration[5.2]
  def change
    create_table :accessories do |t|
      t.string :name
      t.string :description
      t.decimal :daily_rate
      t.string :photo

      t.timestamps
    end
  end
end
