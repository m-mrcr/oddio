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

ActiveRecord::Schema.define(version: 2019_07_25_022142) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "app_auths", force: :cascade do |t|
    t.bigint "user_id"
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_app_auths_on_user_id"
  end

  create_table "google_auths", force: :cascade do |t|
    t.bigint "user_id"
    t.string "uid"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_google_auths_on_user_id"
  end

  create_table "landmarks", force: :cascade do |t|
    t.string "name"
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "long", precision: 10, scale: 6
    t.string "address"
    t.string "phone_number"
    t.string "category"
    t.string "place_id"
    t.string "website"
    t.string "photo_reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "md5_hash"
  end

  create_table "recordings", force: :cascade do |t|
    t.string "title"
    t.text "url"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "landmark_id"
    t.index ["landmark_id"], name: "index_recordings_on_landmark_id"
    t.index ["user_id"], name: "index_recordings_on_user_id"
  end

  create_table "tour_recordings", force: :cascade do |t|
    t.bigint "tour_id"
    t.bigint "recording_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recording_id"], name: "index_tour_recordings_on_recording_id"
    t.index ["tour_id"], name: "index_tour_recordings_on_tour_id"
  end

  create_table "tours", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tours_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "display_name"
    t.string "vote_token"
  end

  add_foreign_key "app_auths", "users"
  add_foreign_key "google_auths", "users"
  add_foreign_key "recordings", "landmarks"
  add_foreign_key "recordings", "users"
  add_foreign_key "tour_recordings", "recordings"
  add_foreign_key "tour_recordings", "tours"
  add_foreign_key "tours", "users"
end
