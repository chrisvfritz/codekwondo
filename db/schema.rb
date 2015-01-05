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

ActiveRecord::Schema.define(version: 20150105162703) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "course_relationships", force: true do |t|
    t.integer  "prereq_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_relationships", ["prereq_id", "course_id"], name: "by_course_prereq_direction", unique: true, using: :btree

  create_table "courses", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.string   "abbrev"
    t.integer  "creator_id"
    t.boolean  "featured"
  end

  create_table "languages", force: true do |t|
    t.string   "name"
    t.string   "abbrev"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_completions", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.string   "url"
    t.hstore   "criteria_completion", default: {}, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "github_repo_url"
    t.boolean  "completed"
  end

  add_index "project_completions", ["completed"], name: "index_project_completions_on_completed", using: :btree
  add_index "project_completions", ["project_id", "user_id"], name: "by_project_and_user", unique: true, using: :btree

  create_table "project_criteria", force: true do |t|
    t.integer  "project_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.integer  "skill_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
  end

  create_table "resources", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.integer  "skill_id"
    t.string   "url"
    t.boolean  "paid"
    t.decimal  "price",      precision: 8, scale: 2
    t.integer  "creator_id"
  end

  create_table "skill_relationships", force: true do |t|
    t.integer  "prereq_id"
    t.integer  "skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skill_relationships", ["prereq_id", "skill_id"], name: "by_skill_prereq_direction", unique: true, using: :btree

  create_table "skills", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "primary_language_id"
    t.integer  "position"
    t.integer  "course_id"
    t.text     "presentation"
    t.integer  "creator_id"
    t.string   "gist_id"
    t.boolean  "read_only",           default: false
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "image_url"
    t.string   "github_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.text     "stackoverflow_omniauth_hash"
    t.integer  "stackoverflow_id"
    t.string   "stackoverflow_url"
    t.text     "github_omniauth_hash"
    t.string   "github_token"
  end

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "votes", force: true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

end
