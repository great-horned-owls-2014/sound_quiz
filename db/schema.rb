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

ActiveRecord::Schema.define(version: 20141001191622) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: true do |t|
    t.string   "name"
    t.integer  "itunes_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artists", ["itunes_id"], name: "index_artists_on_itunes_id", using: :btree

  create_table "questions", force: true do |t|
    t.integer  "track_id"
    t.integer  "quiz_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["quiz_id"], name: "index_questions_on_quiz_id", using: :btree
  add_index "questions", ["track_id"], name: "index_questions_on_track_id", using: :btree

  create_table "quizzes", force: true do |t|
    t.integer  "artist_id"
    t.integer  "difficulty_level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quizzes", ["artist_id"], name: "index_quizzes_on_artist_id", using: :btree

  create_table "taken_quizzes", force: true do |t|
    t.integer  "user_id"
    t.integer  "quiz_id"
    t.integer  "artist_id"
    t.integer  "time"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taken_quizzes", ["artist_id"], name: "index_taken_quizzes_on_artist_id", using: :btree
  add_index "taken_quizzes", ["quiz_id"], name: "index_taken_quizzes_on_quiz_id", using: :btree
  add_index "taken_quizzes", ["user_id"], name: "index_taken_quizzes_on_user_id", using: :btree

  create_table "tracks", force: true do |t|
    t.string   "name"
    t.string   "preview_url"
    t.string   "art_url"
    t.integer  "artist_id"
    t.integer  "itunes_track_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tracks", ["artist_id"], name: "index_tracks_on_artist_id", using: :btree
  add_index "tracks", ["itunes_track_id"], name: "index_tracks_on_itunes_track_id", using: :btree
  add_index "tracks", ["name"], name: "index_tracks_on_name", using: :btree

  create_table "user_answers", force: true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "track_id"
    t.float    "response_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_answers", ["question_id"], name: "index_user_answers_on_question_id", using: :btree
  add_index "user_answers", ["track_id"], name: "index_user_answers_on_track_id", using: :btree
  add_index "user_answers", ["user_id"], name: "index_user_answers_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

  create_table "wrong_choices", force: true do |t|
    t.integer  "track_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wrong_choices", ["question_id"], name: "index_wrong_choices_on_question_id", using: :btree
  add_index "wrong_choices", ["track_id"], name: "index_wrong_choices_on_track_id", using: :btree

end
