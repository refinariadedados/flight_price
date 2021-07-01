class CreateAirports < ActiveRecord::Migration[6.1]
  def change
    create_table :airports do |t|
      t.string :airport_id
      t.string :airport_name
      t.string :city_id
      t.string :airport_coordinates
      t.string :city_name
      t.string :city_coordinates
      t.string :iata_code
      t.string :country_id

      t.timestamps
    end
  end
end
