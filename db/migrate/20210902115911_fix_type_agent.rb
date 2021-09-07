class FixTypeAgent < ActiveRecord::Migration[6.1]
  def change
    rename_column :agents, :type, :agent_type
    rename_column :places, :type, :place_type
  end
end
