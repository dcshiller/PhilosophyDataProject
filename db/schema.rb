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

ActiveRecord::Schema.define(version: 20161211141557) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "journals", force: :cascade do |t|
    t.string  "name"
    t.integer "official_version"
    t.boolean "economics",        default: false
    t.boolean "history",          default: false
    t.boolean "philosophy",       default: false
    t.boolean "psychology",       default: false
    t.index ["name"], name: "index_journals_on_name", using: :btree
  end

end
