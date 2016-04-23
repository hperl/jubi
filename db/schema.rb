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

ActiveRecord::Schema.define(version: 20160323110636) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "but_registrations", force: :cascade do |t|
    t.string   "name",                     default: "",    null: false
    t.text     "address",                  default: "",    null: false
    t.string   "nickname"
    t.boolean  "wants_to_offer_workshop",  default: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "estimated_checkin_day",    default: 0
    t.integer  "estimated_checkin_time",   default: 9
    t.integer  "estimated_checkout_day",   default: 3
    t.integer  "estimated_checkout_time",  default: 5
    t.integer  "accomodation",             default: 0
    t.integer  "room_mates",               default: 0
    t.integer  "accomodation_group_id"
    t.boolean  "wants_to_help_checkin",    default: false
    t.boolean  "wants_to_help_freestyler", default: false
    t.boolean  "wants_to_help_party",      default: false
    t.boolean  "wants_to_help_kiosk",      default: false
    t.boolean  "wants_to_help_ersthelfer", default: false
    t.boolean  "wants_to_help_grillen",    default: false
    t.integer  "sex",                      default: 2,     null: false
    t.integer  "age"
    t.string   "t_shirt_size",             default: "0",   null: false
    t.integer  "diet",                     default: 0
    t.text     "diet_other",               default: ""
    t.text     "comment"
    t.integer  "state",                    default: 0
    t.integer  "lg",                       default: 0
    t.boolean  "is_early_bird",            default: false
    t.boolean  "visible",                  default: false
    t.integer  "transportation",           default: 0,     null: false
  end

  create_table "but_registrations_timeslots", id: false, force: :cascade do |t|
    t.integer "but_registration_id"
    t.integer "timeslot_id"
  end

  add_index "but_registrations_timeslots", ["but_registration_id"], name: "index_but_registrations_timeslots_on_but_registration_id", using: :btree
  add_index "but_registrations_timeslots", ["timeslot_id"], name: "index_but_registrations_timeslots_on_timeslot_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string  "name"
    t.integer "owner_id"
  end

  create_table "groups_users", force: :cascade do |t|
    t.integer "group_id"
    t.integer "user_id"
  end

  create_table "invitations", id: false, force: :cascade do |t|
    t.string   "id"
    t.string   "email"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "amount_in_cents",     default: 0
    t.integer  "user_id"
    t.integer  "responsible_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timeslots", force: :cascade do |t|
    t.integer  "kind"
    t.datetime "start"
    t.datetime "end"
    t.integer  "max_tn"
    t.string   "name_de",        default: "", null: false
    t.string   "name_en",        default: "", null: false
    t.string   "description_de", default: "", null: false
    t.string   "description_en", default: "", null: false
  end

  create_table "timeslots_workshops", force: :cascade do |t|
    t.integer "timeslot_id"
    t.integer "workshop_id"
  end

  create_table "users", force: :cascade do |t|
    t.boolean  "intranet_user",           default: false, null: false
    t.boolean  "kernteam",                default: false, null: false
    t.string   "email",                   default: "",    null: false
    t.string   "encrypted_password",      default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "remembered_workshop_ids"
    t.boolean  "extended_kernteam",       default: false, null: false
    t.text     "music_wishes",            default: ""
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "workshop_choices", force: :cascade do |t|
    t.integer  "but_registration_id"
    t.integer  "workshop_id"
    t.integer  "choice_type",         default: 1
    t.boolean  "final",               default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "trainer"
  end

  create_table "workshops", force: :cascade do |t|
    t.string   "title"
    t.string   "trainers",             default: ""
    t.text     "description"
    t.string   "price"
    t.text     "special_requirements"
    t.text     "timeframe"
    t.text     "materials"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "max_tn"
    t.boolean  "visible",              default: false
    t.boolean  "helper_shift",         default: false
  end

end
