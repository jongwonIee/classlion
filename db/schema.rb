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

ActiveRecord::Schema.define(version: 20170518091439) do

  create_table "auth_tokens", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "auth_type", null: false
    t.string "token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer "evaluation_id", null: false
    t.integer "user_id", null: false
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.integer "professor_id", null: false
    t.integer "lecture_id", null: false
    t.integer "university_id", null: false
    t.boolean "is_major", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evaluations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "course_id", null: false
    t.integer "like_id", null: false
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["like_id"], name: "index_evaluations_on_like_id", unique: true
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lectures", force: :cascade do |t|
    t.string "name", null: false
    t.integer "university_id", null: false
    t.integer "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "course_id", null: false
    t.boolean "is_like", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "professors", force: :cascade do |t|
    t.integer "university_id", null: false
    t.string "name", null: false
    t.string "photo_url"
    t.integer "uploader_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "evaluation_id", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "universities", force: :cascade do |t|
    t.string "local_name", null: false
    t.string "english_name", null: false
    t.string "email_domain", null: false
    t.boolean "need_activation", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "nickname", null: false
    t.string "email", null: false
    t.integer "university_id", null: false
    t.string "password_digest", null: false
    t.string "remember_digest"
    t.boolean "is_boy", null: false
    t.boolean "confirmed", default: false, null: false
    t.boolean "dropped_out", default: false, null: false
    t.datetime "dropped_out_at"
    t.integer "point", default: 0, null: false
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "wikis", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "revision", null: false
    t.integer "course_id", null: false
    t.integer "diff", null: false
    t.text "body", null: false
    t.integer "rollback", default: -1, null: false
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id", "revision"], name: "index_wikis_on_course_id_and_revision", unique: true
    t.index ["revision"], name: "index_wikis_on_revision"
  end

end
