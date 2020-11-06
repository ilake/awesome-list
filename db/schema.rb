# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_06_005858) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "technology_id", null: false
    t.string "name", null: false
    t.index ["user_id", "name"], name: "index_categories_on_user_id_and_name", unique: true
    t.index ["user_id", "technology_id"], name: "index_categories_on_user_id_and_technology_id", unique: true
  end

  create_table "repositories", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.string "name", null: false
    t.jsonb "details"
    t.index ["user_id", "name"], name: "index_repositories_on_user_id_and_name", unique: true
  end

  create_table "technologies", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.index ["user_id", "name"], name: "index_technologies_on_user_id_and_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
  end

end
