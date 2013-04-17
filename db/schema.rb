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

ActiveRecord::Schema.define(:version => 20130416190759) do

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

  create_table "authentications", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_token_expires_at"
    t.integer  "user_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "cart_items", :force => true do |t|
    t.string   "name"
    t.decimal  "price",              :precision => 8, :scale => 2
    t.integer  "quantity",                                         :default => 1
    t.string   "note"
    t.integer  "cart_id"
    t.datetime "created_at",                                                      :null => false
    t.datetime "updated_at",                                                      :null => false
    t.integer  "cart_itemable_id"
    t.string   "cart_itemable_type"
  end

  add_index "cart_items", ["cart_id"], :name => "index_cart_items_on_cart_id"
  add_index "cart_items", ["cart_itemable_id", "cart_itemable_type"], :name => "index_cart_items_on_cart_itemable_id_and_cart_itemable_type"

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
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "rank",       :default => 0, :null => false
  end

  add_index "categories", ["menu_id"], :name => "index_categories_on_menu_id"

  create_table "coupons", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.string   "photo"
    t.integer  "store_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.integer  "rank",                                     :default => 0,    :null => false
    t.decimal  "price",      :precision => 8, :scale => 2, :default => 0.0
    t.text     "scope"
    t.decimal  "minimum",    :precision => 8, :scale => 2, :default => 20.0
  end

  add_index "coupons", ["store_id"], :name => "index_coupons_on_store_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

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

  create_table "dish_discounts", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.decimal  "price"
    t.integer  "store_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "dish_discounts", ["store_id"], :name => "index_dish_discounts_on_store_id"

  create_table "dish_discounts_dishes", :id => false, :force => true do |t|
    t.integer "dish_discount_id"
    t.integer "dish_id"
  end

  add_index "dish_discounts_dishes", ["dish_discount_id", "dish_id"], :name => "index_dish_discounts_dishes_on_dish_discount_id_and_dish_id"
  add_index "dish_discounts_dishes", ["dish_discount_id"], :name => "index_dish_discounts_dishes_on_dish_discount_id"
  add_index "dish_discounts_dishes", ["dish_id"], :name => "index_dish_discounts_dishes_on_dish_id"

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
    t.string   "photo"
    t.integer  "category_id"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.integer  "rank",                                      :default => 0, :null => false
  end

  add_index "dishes", ["category_id"], :name => "index_dishes_on_category_id"

  create_table "galleries", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.integer  "galleriable_id"
    t.string   "galleriable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "gallery_photos", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.string   "photo"
    t.integer  "gallery_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "gallery_photos", ["gallery_id"], :name => "index_gallery_photos_on_gallery_id"

  create_table "hours", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.string   "open_at"
    t.string   "close_at"
    t.integer  "hourable_id"
    t.string   "hourable_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "menus", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.integer  "store_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "rank",       :default => 0, :null => false
  end

  add_index "menus", ["store_id"], :name => "index_menus_on_store_id"

  create_table "orders", :force => true do |t|
    t.string   "payment_type",                                 :default => "cash",     :null => false
    t.string   "payment_status",                               :default => "not_paid", :null => false
    t.string   "note"
    t.decimal  "tip",            :precision => 8, :scale => 2, :default => 0.0
    t.integer  "store_id"
    t.integer  "cart_id"
    t.integer  "user_id"
    t.datetime "created_at",                                                           :null => false
    t.datetime "updated_at",                                                           :null => false
    t.boolean  "handled",                                      :default => false,      :null => false
    t.string   "status"
    t.string   "expected_at",                                  :default => "ASAP",     :null => false
  end

  add_index "orders", ["cart_id"], :name => "index_orders_on_cart_id"
  add_index "orders", ["store_id"], :name => "index_orders_on_store_id"
  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "payments", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.string   "avatar"
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
    t.string   "photo"
    t.integer  "store_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "rank",       :default => 0, :null => false
  end

  add_index "plans", ["store_id"], :name => "index_plans_on_store_id"

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

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

  create_table "services", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "services_stores", :id => false, :force => true do |t|
    t.integer "service_id"
    t.integer "store_id"
  end

  add_index "services_stores", ["service_id", "store_id"], :name => "index_services_stores_on_service_id_and_store_id"
  add_index "services_stores", ["service_id"], :name => "index_services_stores_on_service_id"
  add_index "services_stores", ["store_id"], :name => "index_services_stores_on_store_id"

  create_table "stores", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.string   "avatar"
    t.string   "phone"
    t.string   "fax"
    t.decimal  "delivery_minimum"
    t.decimal  "delivery_fee"
    t.integer  "delivery_radius"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "rank",             :default => 0, :null => false
    t.text     "story"
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
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "rank",       :default => 0, :null => false
  end

  create_table "tickets", :force => true do |t|
    t.string   "email"
    t.text     "content"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "handled",    :default => false, :null => false
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "avatar"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "phone"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
