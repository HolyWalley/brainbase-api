# frozen_string_literal: true

class CreatePieces < ActiveRecord::Migration[6.0]
  def change
    create_table :pieces do |t|
      t.references :learner, foreign_key: true, index: true

      t.references :parent, foreign_key: { to_table: :pieces }, null: true

      t.string :name, null: false
      t.text :content

      t.timestamps
    end
  end
end
