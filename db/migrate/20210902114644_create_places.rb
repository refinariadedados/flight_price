class CreatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :places do |t|
      t.string :code
      t.string :name
      t.string :type
      t.string :place_id
      t.string :parent_id

      t.timestamps
    end
  end
end
