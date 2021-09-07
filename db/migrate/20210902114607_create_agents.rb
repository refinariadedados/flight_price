class CreateAgents < ActiveRecord::Migration[6.1]
  def change
    create_table :agents do |t|
      t.string :name
      t.string :type
      t.string :id_agent

      t.timestamps
    end
  end
end
