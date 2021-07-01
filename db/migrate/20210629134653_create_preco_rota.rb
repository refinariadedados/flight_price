class CreatePrecoRota < ActiveRecord::Migration[6.1]
  def change
    create_table :preco_rota do |t|
      t.jsonb :content

      t.timestamps
    end
  end
end
