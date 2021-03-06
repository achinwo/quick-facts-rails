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

ActiveRecord::Schema.define(version: 20160116124157) do

  create_table "attachments", force: :cascade do |t|
    t.string   "extension"
    t.integer  "fact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "facts", force: :cascade do |t|
    t.text     "content"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "user_id"
    t.boolean  "deleted",    default: false
    t.integer  "group_id"
  end

  add_index "facts", ["user_id"], name: "index_facts_on_user_id"

  create_table "group_memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.boolean  "activated",          default: false
    t.string   "activtation_digest"
  end

  add_index "group_memberships", ["group_id"], name: "index_group_memberships_on_group_id"
  add_index "group_memberships", ["user_id", "group_id"], name: "index_group_memberships_on_user_id_and_group_id", unique: true
  add_index "group_memberships", ["user_id"], name: "index_group_memberships_on_user_id"

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.boolean  "deleted",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "groups", ["user_id"], name: "index_groups_on_user_id"

  create_table "preferences", force: :cascade do |t|
    t.string   "name"
    t.string   "value"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "fact_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["category_id"], name: "index_relationships_on_category_id"
  add_index "relationships", ["fact_id", "category_id"], name: "index_relationships_on_fact_id_and_category_id", unique: true
  add_index "relationships", ["fact_id"], name: "index_relationships_on_fact_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "password_digest"
    t.string   "activation_digest"
    t.boolean  "activated",              default: false
    t.datetime "activated_at"
    t.string   "password_reset_digest"
    t.datetime "password_reset_sent_at"
    t.boolean  "admin",                  default: false
    t.string   "remember_me_digest"
    t.boolean  "deleted",                default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "variables", force: :cascade do |t|
    t.integer  "user"
    t.string   "name"
    t.text     "value"
    t.boolean  "deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
