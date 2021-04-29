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

ActiveRecord::Schema.define(version: 20210428194856) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "galleries", force: :cascade do |t|
    t.string   "gallery_title"
    t.text     "gallery_description"
    t.string   "gallery_picture",                  array: true
    t.float    "gallery_totalRate"
    t.integer  "gallery_totalRator"
    t.integer  "GeneralInfo_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "gallery"
  end

  create_table "general_infos", force: :cascade do |t|
    t.string   "userKey"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "month_ofbirth"
    t.integer  "day_ofbirth"
    t.integer  "year_ofbirth"
    t.string   "gender"
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.string   "compensation"
    t.string   "facebook_link"
    t.string   "linkedIn_link"
    t.string   "instagram_link"
    t.string   "personalWebsite_link"
    t.text     "bio"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "specific_profile_id"
    t.string   "profile_picture"
    t.string   "cover_picture"
    t.string   "gallery_pictures",                  array: true
    t.integer  "template_id"
    t.json     "specific_profile"
    t.string   "phone"
    t.float    "latitude"
    t.float    "longitude"
    t.text     "job_attr"
    t.string   "job_name"
    t.boolean  "is_admin"
  end

  create_table "login_infos", force: :cascade do |t|
    t.string   "email"
    t.string   "password"
    t.string   "userKey"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "is_admin"
  end

  create_table "models", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_models_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_models_on_reset_password_token", unique: true, using: :btree
  end

  create_table "specific_designers", force: :cascade do |t|
    t.text     "genre"
    t.text     "influencers"
    t.text     "specialties"
    t.string   "compensation"
    t.string   "experience"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "user_key"
  end

  create_table "specific_models", force: :cascade do |t|
    t.integer  "height_feet"
    t.integer  "height_inches"
    t.integer  "bust"
    t.integer  "waist"
    t.integer  "hips"
    t.string   "cups"
    t.integer  "shoe_size"
    t.integer  "dress_size"
    t.string   "hair_color"
    t.string   "eye_color"
    t.string   "ethnicity"
    t.string   "skin_color"
    t.string   "shoot_nudes"
    t.string   "tattoos"
    t.string   "piercings"
    t.string   "experience"
    t.text     "genre"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "user_key"
  end

  create_table "specific_photographers", force: :cascade do |t|
    t.string   "compensation"
    t.string   "experience"
    t.text     "influencers"
    t.text     "specialties"
    t.text     "genre"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "user_key"
    t.string   "state"
  end

  create_table "templates", force: :cascade do |t|
    t.string   "prof_name"
    t.json     "prof_attribute"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.text     "image"
    t.string   "password"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
