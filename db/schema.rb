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

ActiveRecord::Schema.define(:version => 20110228104510) do

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
  end

  create_table "distributors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

end
