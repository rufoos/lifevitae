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

ActiveRecord::Schema.define(version: 2018_12_04_093754) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "cities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "country_id"
    t.string "en_name"
    t.string "state"
    t.boolean "visible", default: true
  end

  create_table "countries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "en_name"
    t.boolean "visible", default: true
    t.string "code", limit: 3
    t.string "code2", limit: 2
  end

  create_table "life_events", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.integer "user_id"
  end

  create_table "life_moment_strengths", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "life_moment_id", null: false
    t.string "name", null: false
    t.integer "user_id"
    t.index ["life_moment_id"], name: "index_life_moment_strengths_on_life_moment_id"
  end

  create_table "life_moments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "main_question"
    t.string "sub_question_1"
    t.string "sub_question_2"
    t.string "sub_question_3"
    t.integer "sort"
  end

  create_table "life_skills", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.integer "user_id"
  end

  create_table "user_achievements", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "achievement_name", null: false
    t.index ["user_id"], name: "index_user_achievements_on_user_id"
  end

  create_table "user_answer_strengths", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_answer_id", null: false
    t.integer "life_moment_strength_id", null: false
    t.index ["life_moment_strength_id"], name: "index_user_answer_strengths_on_life_moment_strength_id"
    t.index ["user_answer_id"], name: "index_user_answer_strengths_on_user_answer_id"
  end

  create_table "user_answers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "life_moment_id", null: false
    t.string "answer_1"
    t.string "answer_2"
    t.string "answer_3"
    t.index ["life_moment_id"], name: "index_user_answers_on_life_moment_id"
    t.index ["user_id"], name: "index_user_answers_on_user_id"
  end

  create_table "user_events", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "life_event_id", null: false
    t.integer "year", limit: 2
    t.integer "event_type", limit: 1
    t.index ["life_event_id"], name: "index_user_events_on_life_event_id"
    t.index ["user_id"], name: "index_user_events_on_user_id"
  end

  create_table "user_past_cities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "country_id", null: false
    t.integer "city_id", null: false
    t.index ["city_id"], name: "index_user_past_cities_on_city_id"
    t.index ["country_id"], name: "index_user_past_cities_on_country_id"
    t.index ["user_id"], name: "index_user_past_cities_on_user_id"
  end

  create_table "user_providers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "username"
    t.string "provider", null: false
    t.string "uid", null: false
    t.text "token"
    t.string "avatar_link"
    t.bigint "expires_at"
    t.string "refresh_token"
    t.index ["user_id"], name: "index_user_providers_on_user_id"
  end

  create_table "user_skills", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "life_skill_id", null: false
    t.index ["life_skill_id"], name: "index_user_skills_on_life_skill_id"
    t.index ["user_id"], name: "index_user_skills_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fullname", null: false
    t.date "birth_date"
    t.string "phone"
    t.integer "gender", limit: 1
    t.integer "country_id"
    t.integer "city_id"
    t.string "looking_for"
    t.string "job_current_role"
    t.string "job_org_name"
    t.string "job_about_desc"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
