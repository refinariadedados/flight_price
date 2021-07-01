class CreateTrajectories < ActiveRecord::Migration[6.1]
  def change
    create_table :trajectories do |t|
      t.string :origin
      t.string :destiny

      t.timestamps
    end
  end
end
