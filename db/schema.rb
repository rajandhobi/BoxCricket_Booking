# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_02_06_102212) do
  create_table "branches", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grounds", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "pincode"
    t.string "ground_type"
    t.integer "capicity"
    t.decimal "price_per_hour"
    t.boolean "availabiity"
    t.time "open_time"
    t.time "close_time"
    t.text "facility"
    t.string "contact_number"
    t.string "email"
    t.text "description"
    t.integer "branch_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_grounds_on_branch_id"
  end

  add_foreign_key "grounds", "branches"
end
