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

ActiveRecord::Schema.define(version: 2023_10_08_194921) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.bigint "state_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "gallery_id", null: false
    t.index ["gallery_id"], name: "index_comments_on_gallery_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "iso3"
    t.string "phone_code"
    t.string "capital"
    t.string "currency"
    t.string "region"
    t.string "subregion"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["iso3"], name: "index_countries_on_iso3", unique: true
  end

  create_table "follows", force: :cascade do |t|
    t.integer "follower_id", null: false
    t.integer "followee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "galleries", id: :serial, force: :cascade do |t|
    t.string "gallery_title"
    t.text "gallery_description"
    t.string "gallery_picture", array: true
    t.float "gallery_totalRate"
    t.integer "gallery_totalRator"
    t.integer "GeneralInfo_id"
    t.string "test_picture", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gallery"
    t.text "comments", default: [], array: true
  end

  create_table "gallery_taggings", force: :cascade do |t|
    t.bigint "gallery_id", null: false
    t.bigint "general_info_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "tagged_user_id"
    t.string "invited_email"
    t.index ["gallery_id"], name: "index_gallery_taggings_on_gallery_id"
    t.index ["general_info_id"], name: "index_gallery_taggings_on_general_info_id"
  end

  create_table "general_infos", id: :serial, force: :cascade do |t|
    t.string "userKey"
    t.string "first_name"
    t.string "last_name"
    t.integer "month_ofbirth"
    t.integer "day_ofbirth"
    t.integer "year_ofbirth"
    t.string "gender"
    t.string "company"
    t.string "highlights"
    t.string "industry"
    t.string "country"
    t.string "state"
    t.string "city"
    t.string "compensation"
    t.string "facebook_link"
    t.string "linkedIn_link"
    t.string "instagram_link"
    t.string "personalWebsite_link"
    t.text "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "specific_profile_id"
    t.string "profile_picture"
    t.string "cover_picture"
    t.string "gallery_pictures", array: true
    t.integer "template_id"
    t.json "specific_profile"
    t.string "phone"
    t.float "latitude"
    t.float "longitude"
    t.text "job_attr"
    t.string "job_name"
    t.boolean "is_admin"
    t.string "email"
    t.string "specialization"
    t.string "profdetails"
    t.string "experience"
    t.string "emailaddr"
    t.boolean "notification", default: false
    t.integer "notification_from", default: [], array: true
    t.string "travel_country"
    t.string "travel_state"
    t.string "travel_city"
    t.date "travel_start"
    t.date "travel_end"
    t.string "travel_details"
  end

  create_table "job_infos", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "category"
    t.string "profession"
    t.string "country"
    t.string "state"
    t.string "city"
    t.string "type"
    t.integer "low_salary"
    t.integer "high_salary"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "userKey"
  end

  create_table "login_infos", id: :serial, force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.string "userKey"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "is_admin"
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.integer "general_info_id"
    t.integer "room_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "chatting_with"
    t.index ["general_info_id"], name: "index_messages_on_general_info_id"
    t.index ["room_id"], name: "index_messages_on_room_id"
  end

  create_table "models", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_models_on_email", unique: true
    t.index ["reset_password_token"], name: "index_models_on_reset_password_token", unique: true
  end

  create_table "reviews", id: :serial, force: :cascade do |t|
    t.integer "rating"
    t.text "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "general_info_id"
    t.integer "gallery_id"
    t.integer "user_id"
  end

  create_table "rooms", id: :serial, force: :cascade do |t|
    t.string "name"
    t.boolean "is_private", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "specific_designers", id: :serial, force: :cascade do |t|
    t.text "genre"
    t.text "influencers"
    t.text "specialties"
    t.string "compensation"
    t.string "experience"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_key"
  end

  create_table "specific_models", id: :serial, force: :cascade do |t|
    t.integer "height_feet"
    t.integer "height_inches"
    t.integer "bust"
    t.integer "waist"
    t.integer "hips"
    t.string "cups"
    t.integer "shoe_size"
    t.integer "dress_size"
    t.string "hair_color"
    t.string "eye_color"
    t.string "ethnicity"
    t.string "skin_color"
    t.string "shoot_nudes"
    t.string "tattoos"
    t.string "piercings"
    t.string "experience"
    t.text "genre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_key"
  end

  create_table "specific_photographers", id: :serial, force: :cascade do |t|
    t.string "compensation"
    t.string "experience"
    t.text "influencers"
    t.text "specialties"
    t.text "genre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_key"
    t.string "state"
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "state_code"
    t.float "latitude"
    t.float "longitude"
    t.bigint "country_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_states_on_country_id"
  end

  create_table "templates", id: :serial, force: :cascade do |t|
    t.string "prof_name"
    t.json "prof_attribute"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_activity_details", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "logged_in_at"
    t.datetime "last_active_at"
    t.integer "time_spent_on_website"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.text "image"
    t.string "password"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cities", "states"
  add_foreign_key "comments", "galleries"
  add_foreign_key "gallery_taggings", "galleries"
  add_foreign_key "gallery_taggings", "general_infos"
  add_foreign_key "messages", "general_infos"
  add_foreign_key "messages", "rooms"
  add_foreign_key "states", "countries"
end
