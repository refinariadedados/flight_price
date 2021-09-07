class CreateCarriers < ActiveRecord::Migration[6.1]
  def change
    create_table :carriers do |t|
      t.string :carrier_id
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
