# frozen_string_literal: true

class CreateLearner < ActiveRecord::Migration[6.0]
  def change
    create_table :learners do |t|
      t.string :email, null: false, index: true
      t.string :password_digest, null: false
      t.string :username, null: false
    end

    add_index :learners, :email, unique: true, name: :unique_index_learners_on_email
    add_index :learners, :username, unique: true, name: :unique_index_learners_on_username
  end
end
