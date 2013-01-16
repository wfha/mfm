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

ActiveRecord::Schema.define(:version => 20121211155102) do

  create_table "addresses", :force => true do |t|
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "addresses", ["addressable_id", "addressable_type"], :name => "index_addresses_on_addressable_id_and_addressable_type"

  create_table "cart_items", :force => true do |t|
    t.string   "name"
    t.decimal  "price",      :precision => 8, :scale => 2
    t.integer  "quantity",                                 :default => 1
    t.string   "note"
    t.integer  "dish_id"
    t.integer  "cart_id"
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
  end

  add_index "cart_items", ["cart_id"], :name => "index_cart_items_on_cart_id"
  add_index "cart_items", ["dish_id"], :name => "index_cart_items_on_dish_id"

  create_table "carts", :force => true do |t|
    t.string   "delivery_type",                               :default => "delivery", :null => false
    t.decimal  "delivery_fee",  :precision => 8, :scale => 2, :default => 0.0
    t.integer  "store_id"
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
  end

  add_index "carts", ["store_id"], :name => "index_carts_on_store_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.integer  "menu_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "categories", ["menu_id"], :name => "index_categories_on_menu_id"

  create_table "coupons", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.string   "image"
    t.integer  "store_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "coupons", ["store_id"], :name => "index_coupons_on_store_id"

  create_table "dish_choices", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.integer  "store_id"
    t.boolean  "must",       :default => false
    t.integer  "checked",    :default => 0
    t.string   "input_type", :default => "radio"
    t.string   "content",    :default => "abc:0,def:1"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  add_index "dish_choices", ["store_id"], :name => "index_dish_choices_on_store_id"

  create_table "dish_choices_dishes", :id => false, :force => true do |t|
    t.integer "dish_choice_id"
    t.integer "dish_id"
  end

  add_index "dish_choices_dishes", ["dish_choice_id"], :name => "index_dish_choices_dishes_on_dish_choice_id"
  add_index "dish_choices_dishes", ["dish_id", "dish_choice_id"], :name => "index_dish_choices_dishes_on_dish_id_and_dish_choice_id"
  add_index "dish_choices_dishes", ["dish_id"], :name => "index_dish_choices_dishes_on_dish_id"

  create_table "dish_features", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.integer  "store_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "dish_features", ["store_id"], :name => "index_dish_features_on_store_id"

  create_table "dish_features_dishes", :id => false, :force => true do |t|
    t.integer "dish_feature_id"
    t.integer "dish_id"
  end

  add_index "dish_features_dishes", ["dish_feature_id"], :name => "index_dish_features_dishes_on_dish_feature_id"
  add_index "dish_features_dishes", ["dish_id", "dish_feature_id"], :name => "index_dish_features_dishes_on_dish_id_and_dish_feature_id"
  add_index "dish_features_dishes", ["dish_id"], :name => "index_dish_features_dishes_on_dish_id"

  create_table "dishes", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.decimal  "price",       :precision => 8, :scale => 2
    t.string   "image"
    t.integer  "category_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "dishes", ["category_id"], :name => "index_dishes_on_category_id"

  create_table "hours", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.string   "open_at"
    t.string   "close_at"
    t.integer  "store_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "menus", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.integer  "store_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "menus", ["store_id"], :name => "index_menus_on_store_id"

  create_table "orders", :force => true do |t|
    t.string   "invoice"
    t.string   "transaction_id"
    t.string   "payment_type",                                 :default => "cash", :null => false
    t.string   "note"
    t.decimal  "tip",            :precision => 8, :scale => 2, :default => 0.0
    t.integer  "store_id"
    t.integer  "cart_id"
    t.integer  "user_id"
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
  end

  add_index "orders", ["cart_id"], :name => "index_orders_on_cart_id"
  add_index "orders", ["store_id"], :name => "index_orders_on_store_id"
  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

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

  add_index "payments_stores", ["payment_id", "store_id"], :name => "index_payments_stores_on_payment_id_and_store_id"
  add_index "payments_stores", ["payment_id"], :name => "index_payments_stores_on_payment_id"
  add_index "payments_stores", ["store_id"], :name => "index_payments_stores_on_store_id"

  create_table "plans", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.string   "image"
    t.integer  "store_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "plans", ["store_id"], :name => "index_plans_on_store_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id", "user_id"], :name => "index_roles_users_on_role_id_and_user_id"
  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

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

  add_index "stores_tags", ["store_id", "tag_id"], :name => "index_stores_tags_on_store_id_and_tag_id"
  add_index "stores_tags", ["store_id"], :name => "index_stores_tags_on_store_id"
  add_index "stores_tags", ["tag_id"], :name => "index_stores_tags_on_tag_id"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "phone"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
