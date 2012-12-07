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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121206234449) do

  create_table "hours", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.string   "open_at"
    t.string   "close_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "payments", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "payments_stores", :id => false, :force => true do |t|
    t.integer "payment_id"
    t.integer "store_id"
  end

  add_index "payments_stores", ["payment_id"], :name => "index_payments_stores_on_payment_id"
  add_index "payments_stores", ["store_id"], :name => "index_payments_stores_on_store_id"

  create_table "stores", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.string   "image"
    t.string   "phone"
    t.string   "fax"
    t.decimal  "delivery_minimum"
    t.decimal  "delivery_fee"
    t.integer  "delivery_radius"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "stores_tags", :id => false, :force => true do |t|
    t.integer "store_id"
    t.integer "tag_id"
  end

  add_index "stores_tags", ["store_id"], :name => "index_stores_tags_on_store_id"
  add_index "stores_tags", ["tag_id"], :name => "index_stores_tags_on_tag_id"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
