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

ActiveRecord::Schema.define(version: 20161125080102) do

  create_table "comment_of_evaluations", force: :cascade do |t|
    t.integer  "evaluation_id", null: false
    t.integer  "user_id",       null: false
    t.text     "body",          null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "courses", force: :cascade do |t|
    t.integer  "professor_id",                 null: false
    t.integer  "lecture_id",                   null: false
    t.integer  "university_id",                null: false
    t.integer  "evaluation_count", default: 0
    t.integer  "point_overall",    default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "evaluations", force: :cascade do |t|
    t.integer  "user_id",       null: false
    t.integer  "course_id",     null: false
    t.integer  "point_overall", null: false
    t.text     "body",          null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "course_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lectures", force: :cascade do |t|
    t.string   "name",          null: false
    t.string   "code",          null: false
    t.integer  "university_id", null: false
    t.integer  "unit"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "majors", force: :cascade do |t|
    t.string   "name",          null: false
    t.integer  "university_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "professors", force: :cascade do |t|
    t.integer  "university_id", null: false
    t.string   "name",          null: false
    t.string   "photo_url"
    t.integer  "uploader_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "universities", force: :cascade do |t|
    t.string   "local_name",                   null: false
    t.string   "english_name",                 null: false
    t.string   "email_domain",                 null: false
    t.boolean  "need_activation",              null: false
    t.integer  "user_count",       default: 0
    t.integer  "evaluation_count", default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "nickname",                               null: false
    t.string   "email",                                  null: false
    t.integer  "university_id",                          null: false
    t.integer  "major_id",                               null: false
    t.string   "password_digest",                        null: false
    t.string   "remember_digest"
    t.boolean  "is_boy",                                 null: false
    t.boolean  "confirmed",              default: false, null: false
    t.boolean  "dropped_out",            default: false, null: false
    t.datetime "dropped_out_at"
    t.boolean  "allowed",                default: false, null: false
    t.integer  "point",                  default: 0,     null: false
    t.integer  "sign_in_count",          default: 1,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "confirmation_is_needed", default: false, null: false
    t.string   "confirmation_token"
    t.datetime "confirmation_sent_at"
    t.datetime "confirmed_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

  create_table "wikis", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "course_id",  null: false
    t.text     "body",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
