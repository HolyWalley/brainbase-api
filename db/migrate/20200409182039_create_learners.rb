# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :learners do
      primary_key :id

      column :email, String, null: false, unique: true
      column :password_digest, String, null: false

      column :first_name, String
      column :last_name, String
      column :nick_name, String
      column :city, String

      column :age, Integer

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
