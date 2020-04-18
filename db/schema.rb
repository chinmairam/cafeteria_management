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

ActiveRecord::Schema.define(version: 2020_04_18_182717) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "menu_items", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "menu_id"
    t.text "name"
    t.text "description"
    t.integer "price"
  end

  create_table "menus", id: false, force: :cascade do |t|
    t.integer "id"
    t.text "name"
  end

  create_table "menus_items", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "menu_id"
    t.text "name"
    t.text "description"
    t.integer "price"
  end

  create_table "order_items", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "order_id"
    t.integer "menu_item_id"
    t.text "menu_item_name"
    t.integer "menu_item_price"
  end

  create_table "orders", id: false, force: :cascade do |t|
    t.integer "id"
    t.date "date"
    t.integer "user_id"
  end

  create_table "users", id: false, force: :cascade do |t|
    t.integer "id"
    t.text "name"
    t.string "role"
  end

end
