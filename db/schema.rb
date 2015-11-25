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

ActiveRecord::Schema.define(version: 20151125054206) do

  create_table "admins", force: true do |t|
    t.string   "name",                     null: false
    t.string   "email",                    null: false
    t.string   "password",                 null: false
    t.string   "salt",                     null: false
    t.datetime "created_at",               null: false
    t.integer  "created_time",             null: false
    t.integer  "created_user", default: 1, null: false
    t.datetime "deleted_at"
    t.integer  "deleted_time"
    t.integer  "deleted_user"
    t.datetime "updated_at",               null: false
    t.integer  "updated_time",             null: false
    t.integer  "updated_user", default: 1, null: false
  end

  create_table "companies", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "password"
    t.string   "email"
    t.string   "salt"
    t.datetime "created_at",               null: false
    t.integer  "created_time",             null: false
    t.integer  "created_user", default: 1, null: false
    t.datetime "deleted_at"
    t.integer  "deleted_time"
    t.integer  "deleted_user"
    t.datetime "updated_at",               null: false
    t.integer  "updated_time",             null: false
    t.integer  "updated_user", default: 1, null: false
  end

  create_table "events", force: true do |t|
    t.string   "title"
    t.datetime "start"
    t.datetime "end"
    t.string   "color"
    t.boolean  "allDay"
  end

  create_table "projects", force: true do |t|
    t.integer  "sales_user_id",               null: false
    t.integer  "company_id",                  null: false
    t.string   "name",                        null: false
    t.string   "url",                         null: false
    t.integer  "page_type",                   null: false
    t.string   "title"
    t.text     "description"
    t.text     "ogp_description"
    t.datetime "start_at"
    t.datetime "finish_at"
    t.datetime "created_at",                  null: false
    t.integer  "created_time",                null: false
    t.integer  "created_user",    default: 1, null: false
    t.datetime "deleted_at"
    t.integer  "deleted_time"
    t.integer  "deleted_user"
    t.datetime "updated_at",                  null: false
    t.integer  "updated_time",                null: false
    t.integer  "updated_user",    default: 1, null: false
  end

  create_table "supers", force: true do |t|
    t.string   "name",                     null: false
    t.string   "email"
    t.string   "password",                 null: false
    t.string   "salt",                     null: false
    t.datetime "created_at",               null: false
    t.integer  "created_time",             null: false
    t.integer  "created_user", default: 1, null: false
    t.datetime "deleted_at"
    t.integer  "deleted_time"
    t.integer  "deleted_user"
    t.datetime "updated_at",               null: false
    t.integer  "updated_time",             null: false
    t.integer  "updated_user", default: 1, null: false
  end

  create_table "tags", force: true do |t|
    t.string   "name",                     null: false
    t.text     "description",              null: false
    t.datetime "created_at",               null: false
    t.integer  "created_time",             null: false
    t.integer  "created_user", default: 1, null: false
    t.datetime "deleted_at"
    t.integer  "deleted_time"
    t.integer  "deleted_user"
    t.datetime "updated_at",               null: false
    t.integer  "updated_time",             null: false
    t.integer  "updated_user", default: 1, null: false
  end

  create_table "tasks", force: true do |t|
    t.integer  "admin_id"
    t.string   "title"
    t.text     "context"
    t.integer  "state"
    t.datetime "finish_at"
    t.datetime "start_at"
    t.datetime "created_at",               null: false
    t.integer  "created_time",             null: false
    t.integer  "created_user", default: 1, null: false
    t.datetime "deleted_at"
    t.integer  "deleted_time"
    t.integer  "deleted_user"
    t.datetime "updated_at",               null: false
    t.integer  "updated_time",             null: false
    t.integer  "updated_user", default: 1, null: false
  end

end
