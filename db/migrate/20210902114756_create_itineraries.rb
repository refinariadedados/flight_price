class CreateItineraries < ActiveRecord::Migration[6.1]
  def change
    create_table :itineraries do |t|
      t.string :inbound_leg_ig
      t.string :outbound_leg_id
      t.string :price
      t.string :agent

      t.timestamps
    end
  end
end
