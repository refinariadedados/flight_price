class CreateLegs < ActiveRecord::Migration[6.1]
  def change
    create_table :legs do |t|
      t.string :arrival
      t.string :departure
      t.string :origin_station
      t.string :destination_station
      t.string :carrier
      t.string :id_leg

      t.timestamps
    end
  end
end
