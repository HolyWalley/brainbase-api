class CreatePiecesConnections < ActiveRecord::Migration[6.0]
  def change
    create_table :pieces_connections do |t|
      t.references :learner, foreign_key: true, index: true

      t.references :parent, foreign_key: { to_table: :pieces }
      t.references :child, foreign_key: { to_table: :pieces }

      t.timestamps
    end
  end
end
