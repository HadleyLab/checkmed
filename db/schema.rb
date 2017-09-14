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

ActiveRecord::Schema.define(version: 20170914042921) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "name"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree

  create_table "checklist_groups", force: :cascade do |t|
    t.integer  "checklist_id",             null: false
    t.string   "name",                     null: false
    t.integer  "prior",        default: 0, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "checklist_groups", ["checklist_id"], name: "index_checklist_groups_on_checklist_id", using: :btree
  add_index "checklist_groups", ["prior"], name: "index_checklist_groups_on_prior", using: :btree

  create_table "checklist_item_answers", force: :cascade do |t|
    t.integer  "checklist_item_id",             null: false
    t.string   "val",                           null: false
    t.string   "tip"
    t.boolean  "commentable"
    t.integer  "prior",             default: 0, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "checklist_item_answers", ["checklist_item_id"], name: "index_checklist_item_answers_on_checklist_item_id", using: :btree
  add_index "checklist_item_answers", ["prior"], name: "index_checklist_item_answers_on_prior", using: :btree

  create_table "checklist_items", force: :cascade do |t|
    t.integer  "group_id",               null: false
    t.string   "title",                  null: false
    t.text     "descr"
    t.integer  "prior",      default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "picture"
  end

  add_index "checklist_items", ["group_id"], name: "index_checklist_items_on_group_id", using: :btree
  add_index "checklist_items", ["prior"], name: "index_checklist_items_on_prior", using: :btree

  create_table "checklist_types", force: :cascade do |t|
    t.string  "name"
    t.integer "prior", default: 9, null: false
  end

  add_index "checklist_types", ["prior"], name: "index_checklist_types_on_prior", using: :btree

  create_table "checklists", force: :cascade do |t|
    t.integer  "user_id",                           null: false
    t.string   "name",                              null: false
    t.integer  "executor_role_id",                  null: false
    t.integer  "treat_stage"
    t.text     "descr"
    t.integer  "prior",             default: 0,     null: false
    t.boolean  "hided",             default: false, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "speciality_id"
    t.integer  "checklist_type_id"
  end

  add_index "checklists", ["checklist_type_id"], name: "index_checklists_on_checklist_type_id", using: :btree
  add_index "checklists", ["executor_role_id"], name: "index_checklists_on_executor_role_id", using: :btree
  add_index "checklists", ["hided"], name: "index_checklists_on_hided", using: :btree
  add_index "checklists", ["prior"], name: "index_checklists_on_prior", using: :btree
  add_index "checklists", ["speciality_id"], name: "index_checklists_on_speciality_id", using: :btree
  add_index "checklists", ["treat_stage"], name: "index_checklists_on_treat_stage", using: :btree
  add_index "checklists", ["user_id"], name: "index_checklists_on_user_id", using: :btree

  create_table "executor_roles", force: :cascade do |t|
    t.string   "name",                   null: false
    t.integer  "prior",      default: 9, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "executor_roles", ["prior"], name: "index_executor_roles_on_prior", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.string   "path",                       null: false
    t.text     "body"
    t.text     "seodata"
    t.integer  "prior",      default: 9,     null: false
    t.boolean  "hided",      default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "pages", ["hided"], name: "index_pages_on_hided", using: :btree
  add_index "pages", ["path"], name: "index_pages_on_path", unique: true, using: :btree
  add_index "pages", ["prior"], name: "index_pages_on_prior", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "ident",      null: false
    t.integer  "vtype"
    t.text     "val"
    t.boolean  "often"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "settings", ["ident"], name: "index_settings_on_ident", using: :btree
  add_index "settings", ["often"], name: "index_settings_on_often", using: :btree

  create_table "specialities", force: :cascade do |t|
    t.string   "name",                   null: false
    t.integer  "prior",      default: 9, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "specialities", ["prior"], name: "index_specialities_on_prior", using: :btree

  create_table "static_files", force: :cascade do |t|
    t.integer  "holder_id"
    t.string   "holder_type"
    t.string   "file",        null: false
    t.string   "filetype"
    t.string   "name"
    t.float    "size"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "static_files", ["holder_type", "holder_id"], name: "index_static_files_on_holder_type_and_holder_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "name",                                null: false
    t.string   "company",                             null: false
    t.string   "position",                            null: false
    t.string   "avatar"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "banned"
    t.integer  "checklists_count"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "academ_inst"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_checklists_visits", force: :cascade do |t|
    t.integer  "user_id",      null: false
    t.integer  "checklist_id", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "users_checklists_visits", ["checklist_id"], name: "index_users_checklists_visits_on_checklist_id", using: :btree
  add_index "users_checklists_visits", ["user_id"], name: "index_users_checklists_visits_on_user_id", using: :btree

  add_foreign_key "checklist_groups", "checklists"
  add_foreign_key "checklist_item_answers", "checklist_items"
  add_foreign_key "checklists", "checklist_types"
  add_foreign_key "checklists", "specialities"
  add_foreign_key "checklists", "users"
  add_foreign_key "users_checklists_visits", "checklists"
  add_foreign_key "users_checklists_visits", "users"
end
