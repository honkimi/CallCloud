# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141213081041) do

  create_table "invites", force: true do |t|
    t.string   "to_email",   default: "", null: false
    t.integer  "status",     default: 0,  null: false
    t.integer  "tel_id",                  null: false
    t.integer  "user_id",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invites", ["tel_id"], name: "index_invites_on_tel_id"
  add_index "invites", ["to_email", "status"], name: "index_invites_on_to_email_and_status", unique: true
  add_index "invites", ["user_id"], name: "index_invites_on_user_id"

  create_table "records", force: true do |t|
    t.integer  "tel_id",     null: false
    t.string   "from"
    t.string   "voice_url"
    t.string   "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "to"
  end

  add_index "records", ["tel_id"], name: "index_records_on_tel_id"

  create_table "tels", force: true do |t|
    t.string   "organize_name"
    t.string   "base_tel_bumber"
    t.string   "first_msg"
    t.boolean  "is_record",       default: true
    t.text     "sheet"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "voice_type",      default: "woman", null: false
  end

  create_table "twilio_phones", force: true do |t|
    t.string   "number",             null: false
    t.string   "friendly_name",      null: false
    t.string   "sid",                null: false
    t.string   "voice_url",          null: false
    t.string   "voice_fallback_url"
    t.integer  "tel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "twilio_phones", ["tel_id"], name: "index_twilio_phones_on_tel_id"

  create_table "user_tels", force: true do |t|
    t.integer  "user_id",                   null: false
    t.integer  "tel_id",                    null: false
    t.boolean  "is_notify",  default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role"
  end

  add_index "user_tels", ["tel_id"], name: "index_user_tels_on_tel_id"
  add_index "user_tels", ["user_id"], name: "index_user_tels_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "tel"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
