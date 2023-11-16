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

ActiveRecord::Schema[7.0].define(version: 2023_11_15_025002) do
  create_table "art_pieces", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "artist"
    t.index ["latitude"], name: "index_art_pieces_on_latitude"
    t.index ["longitude"], name: "index_art_pieces_on_longitude"
  end

  create_table "badges", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "badge_type"
    t.string "requirement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blog_posts", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_stamps", force: :cascade do |t|
    t.integer "users_id"
    t.integer "art_pieces_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["art_pieces_id"], name: "index_user_stamps_on_art_pieces_id"
    t.index ["users_id"], name: "index_user_stamps_on_users_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "user_type"
    t.integer "badges"
    t.integer "stamps"
  end

  add_foreign_key "user_stamps", "art_pieces", column: "art_pieces_id", on_delete: :cascade
  add_foreign_key "user_stamps", "users", column: "users_id", on_delete: :cascade
end
