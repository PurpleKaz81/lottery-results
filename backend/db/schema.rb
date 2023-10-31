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

ActiveRecord::Schema[7.1].define(version: 2023_10_31_181513) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lotteries", force: :cascade do |t|
    t.string "name"
    t.date "draw_date"
    t.integer "draw_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prize_breakdowns", force: :cascade do |t|
    t.bigint "result_id", null: false
    t.string "prize_category"
    t.integer "winners_count"
    t.decimal "prize_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["result_id"], name: "index_prize_breakdowns_on_result_id"
  end

  create_table "results", force: :cascade do |t|
    t.bigint "lottery_id", null: false
    t.integer "number"
    t.decimal "prize_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lottery_id"], name: "index_results_on_lottery_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "prize_breakdowns", "results"
  add_foreign_key "results", "lotteries"
end
