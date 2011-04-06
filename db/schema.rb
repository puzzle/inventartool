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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110406082745) do

  create_table "disk_versions", :force => true do |t|
    t.integer  "disk_id"
    t.integer  "version"
    t.string   "model"
    t.string   "serial_number"
    t.date     "purchase_date"
    t.date     "warranty_till"
    t.decimal  "price",          :precision => 8, :scale => 2
    t.text     "notes"
    t.integer  "capacity"
    t.string   "connector"
    t.integer  "distributor_id"
    t.integer  "machine_id"
    t.string   "machine_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "creator"
    t.string   "change_notice"
    t.boolean  "in_repair"
  end

  add_index "disk_versions", ["disk_id"], :name => "index_disk_versions_on_disk_id"

  create_table "disks", :force => true do |t|
    t.string   "model"
    t.string   "serial_number"
    t.date     "purchase_date"
    t.date     "warranty_till"
    t.decimal  "price",          :precision => 8, :scale => 2
    t.text     "notes"
    t.integer  "capacity"
    t.string   "connector"
    t.integer  "distributor_id"
    t.integer  "machine_id"
    t.string   "machine_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version"
    t.string   "creator"
    t.string   "change_notice"
    t.boolean  "in_repair"
  end

  create_table "displays", :force => true do |t|
    t.decimal  "price",          :precision => 8, :scale => 2
    t.date     "purchase_date"
    t.string   "serial_number"
    t.string   "model"
    t.text     "notes"
    t.integer  "distributor_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "in_repair"
  end

  create_table "distributors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notebooks", :force => true do |t|
    t.string   "model"
    t.string   "processor"
    t.string   "serial_number"
    t.string   "service_tag"
    t.string   "express_service_code"
    t.decimal  "price"
    t.date     "purchase_date"
    t.date     "warranty_till"
    t.date     "owner_changed_on"
    t.string   "previous_owner"
    t.string   "battery_serial_number"
    t.string   "power_supply_serial_number"
    t.string   "mac_addr_lan"
    t.string   "mac_addr_wlan"
    t.text     "notes"
    t.integer  "distributor_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "in_repair"
  end

  create_table "owners", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rams", :force => true do |t|
    t.integer  "capacity"
    t.string   "description"
    t.integer  "machine_id"
    t.string   "machine_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "serial_number"
    t.boolean  "in_repair"
  end

  create_table "servers", :force => true do |t|
    t.string   "model"
    t.string   "processor"
    t.date     "purchase_date"
    t.date     "warranty_till"
    t.integer  "rack_units"
    t.string   "serial_number"
    t.decimal  "price"
    t.text     "notes"
    t.integer  "distributor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "in_repair"
  end

  create_table "stock_objects", :force => true do |t|
    t.string   "name"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
