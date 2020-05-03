# frozen_string_literal: true

class CreatePieces < ActiveRecord::Migration[6.0]
  def change
    create_table :pieces do |t|
      t.references :learner, foreign_key: true, index: true
      t.string :name, null: false
      t.boolean :root, null: false, default: false
      t.text :content

      t.timestamps
    end
  end
end
