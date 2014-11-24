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

ActiveRecord::Schema.define(version: 20141124223709) do

  create_table "calendar_events", force: true do |t|
    t.string   "title"
    t.datetime "start_time"
    t.datetime "end_time",        limit: 255
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "event_hash",      limit: 64,  default: "INVALID", null: false
    t.integer  "event_source_id"
    t.string   "family_hash",     limit: 64
    t.string   "location",        limit: 256
    t.string   "host",            limit: 256
  end

  add_index "calendar_events", ["event_hash"], name: "index_calendar_events_on_event_hash", unique: true
  add_index "calendar_events", ["event_source_id"], name: "index_calendar_events_on_event_source_id"
  add_index "calendar_events", ["family_hash"], name: "index_calendar_events_on_family_hash", unique: true

  create_table "event_assets", force: true do |t|
    t.integer  "calendar_event_id"
    t.string   "caption"
    t.string   "mime_type"
    t.binary   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

# Could not dump table "event_sources" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "event_tags" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

end
