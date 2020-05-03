# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_01_200704) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "learners", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "username", null: false
    t.index ["email"], name: "index_learners_on_email"
    t.index ["email"], name: "unique_index_learners_on_email", unique: true
    t.index ["username"], name: "unique_index_learners_on_username", unique: true
  end

  create_table "pieces", force: :cascade do |t|
    t.bigint "learner_id"
    t.bigint "parent_id"
    t.string "name", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["learner_id"], name: "index_pieces_on_learner_id"
    t.index ["parent_id"], name: "index_pieces_on_parent_id"
  end

  add_foreign_key "pieces", "learners"
  add_foreign_key "pieces", "pieces", column: "parent_id"
end
