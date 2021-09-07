class FixItinerary < ActiveRecord::Migration[6.1]
  def change
    change_column :itineraries, :price, :jsonb, using: 'price::text::jsonb'
  end
end
