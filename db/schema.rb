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

ActiveRecord::Schema.define(version: 20150623190147) do

  create_table "movies", force: :cascade do |t|
    t.string   "poster"
    t.string   "title"
    t.integer  "upvotes"
    t.integer  "downvotes"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "imdb_id"
    t.string   "plot_summary"
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "vote_type"
    t.integer  "user_id"
    t.integer  "movie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "votes", ["movie_id"], name: "index_votes_on_movie_id"
  add_index "votes", ["user_id"], name: "index_votes_on_user_id"

end
