# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100213152221) do

  create_table "categories", :force => true do |t|
    t.string "group"
    t.string "subgroup"
  end

  create_table "contacts", :force => true do |t|
    t.integer  "contactid"
    t.integer  "labelnumber"
    t.string   "labeldetails"
    t.string   "tags"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "labels", :force => true do |t|
    t.integer  "labelnumber",                  :null => false
    t.string   "labeldetails",  :limit => nil, :null => false
    t.string   "labelcategory", :limit => nil, :null => false
    t.string   "remarks",       :limit => nil
    t.datetime "created_at"
    t.datetime "updated_at"
  end

# Could not dump table "sqlite_stat1" because of following StandardError
#   Unknown type '' for column 'tbl'

end
