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

ActiveRecord::Schema[8.0].define(version: 2025_06_21_165158) do
  create_table "cars", force: :cascade do |t|
    t.string "make"
    t.string "model"
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expenses", force: :cascade do |t|
    t.string "description"
    t.decimal "amount", precision: 10, scale: 2
    t.string "category"
    t.integer "category_ref_id"
    t.date "date"
    t.string "user_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "transaction_type", default: "expense", null: false
    t.index ["category"], name: "index_expenses_on_category"
    t.index ["category_ref_id"], name: "index_expenses_on_category_ref_id"
    t.index ["date"], name: "index_expenses_on_date"
    t.index ["transaction_type"], name: "index_expenses_on_transaction_type"
  end

  add_foreign_key "expenses", "categories", column: "category_ref_id"
end
