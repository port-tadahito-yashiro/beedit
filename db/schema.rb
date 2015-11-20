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

ActiveRecord::Schema.define(version: 20151119115827) do

  create_table "companies", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.text     "description",  limit: 65535
    t.string   "password",     limit: 255
    t.string   "email",        limit: 255
    t.string   "salt",         limit: 255
    t.datetime "created_at",                             null: false
    t.integer  "created_time", limit: 4,                 null: false
    t.integer  "created_user", limit: 4,     default: 1, null: false
    t.datetime "deleted_at"
    t.integer  "deleted_time", limit: 4
    t.integer  "deleted_user", limit: 4
    t.datetime "updated_at",                             null: false
    t.integer  "updated_time", limit: 4,                 null: false
    t.integer  "updated_user", limit: 4,     default: 1, null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name",      limit: 255
    t.datetime "start_at"
    t.datetime "finish_at"
    t.string   "color",     limit: 255
    t.boolean  "allDay"
  end

  create_table "projects", force: :cascade do |t|
    t.integer  "sales_user_id",   limit: 4,                 null: false
    t.integer  "company_id",      limit: 4,                 null: false
    t.string   "name",            limit: 255,               null: false
    t.string   "url",             limit: 255,               null: false
    t.integer  "page_type",       limit: 4,                 null: false
    t.string   "title",           limit: 255
    t.text     "description",     limit: 65535
    t.text     "ogp_description", limit: 65535
    t.datetime "start_at"
    t.datetime "finish_at"
    t.datetime "created_at",                                null: false
    t.integer  "created_time",    limit: 4,                 null: false
    t.integer  "created_user",    limit: 4,     default: 1, null: false
    t.datetime "deleted_at"
    t.integer  "deleted_time",    limit: 4
    t.integer  "deleted_user",    limit: 4
    t.datetime "updated_at",                                null: false
    t.integer  "updated_time",    limit: 4,                 null: false
    t.integer  "updated_user",    limit: 4,     default: 1, null: false
  end

  create_table "supers", force: :cascade do |t|
    t.string   "name",         limit: 255,             null: false
    t.string   "email",        limit: 255
    t.string   "password",     limit: 255,             null: false
    t.string   "salt",         limit: 255,             null: false
    t.datetime "created_at",                           null: false
    t.integer  "created_time", limit: 4,               null: false
    t.integer  "created_user", limit: 4,   default: 1, null: false
    t.datetime "deleted_at"
    t.integer  "deleted_time", limit: 4
    t.integer  "deleted_user", limit: 4
    t.datetime "updated_at",                           null: false
    t.integer  "updated_time", limit: 4,               null: false
    t.integer  "updated_user", limit: 4,   default: 1, null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name",         limit: 255,               null: false
    t.text     "description",  limit: 65535,             null: false
    t.datetime "created_at",                             null: false
    t.integer  "created_time", limit: 4,                 null: false
    t.integer  "created_user", limit: 4,     default: 1, null: false
    t.datetime "deleted_at"
    t.integer  "deleted_time", limit: 4
    t.integer  "deleted_user", limit: 4
    t.datetime "updated_at",                             null: false
    t.integer  "updated_time", limit: 4,                 null: false
    t.integer  "updated_user", limit: 4,     default: 1, null: false
  end

end
