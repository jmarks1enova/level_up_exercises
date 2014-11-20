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

ActiveRecord::Schema.define(version: 20141120160426) do

  create_table "calendar_events", force: true do |t|
    t.string   "title"
    t.datetime "start_time"
    t.string   "end_time"
    t.string   "datetime"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "hash",            limit: 64, default: "INVALID", null: false
    t.integer  "event_source_id"
  end

  create_table "event_assets", force: true do |t|
    t.integer  "calendar_event_id"
    t.string   "caption"
    t.string   "mime_type"
    t.binary   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_sources", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "frequency"
    t.integer  "last_harvest"
    t.text     "json_parameters"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  create_table "event_tags", force: true do |t|
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
