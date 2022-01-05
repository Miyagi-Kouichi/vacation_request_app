# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_31_082221) do

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.text "comment_content", null: false
    t.bigint "user_id"
    t.bigint "holiday_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["holiday_id"], name: "index_comments_on_holiday_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "group_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_group_users_on_group_id"
    t.index ["user_id"], name: "index_group_users_on_user_id"
  end

  create_table "groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "group_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "holidays", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.date "application_date", null: false
    t.time "holiday_time_start"
    t.time "holiday_time_end"
    t.integer "acquisition_time"
    t.string "acquisition_days", null: false
    t.string "reason", null: false
    t.integer "time_record", null: false
    t.float "day_record", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_holidays_on_user_id"
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "group_id"
    t.index ["group_id"], name: "index_notifications_on_group_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "remaining_holidays", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "last_year_days", null: false
    t.integer "last_year_time", null: false
    t.integer "this_year_days", null: false
    t.float "total_days", null: false
    t.integer "total_time", null: false
    t.string "working_hours", null: false
    t.bigint "user_id", null: false
    t.float "changeable_days"
    t.integer "changeable_time"
    t.integer "time_limit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "effective_period_start"
    t.date "effective_period_end"
    t.string "reason"
    t.date "joining_date"
    t.index ["user_id"], name: "index_remaining_holidays_on_user_id"
  end

  create_table "requests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "holiday_id", null: false
    t.string "position", null: false
    t.string "yes_no", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["holiday_id"], name: "index_requests_on_holiday_id"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "user_name", null: false
    t.string "position", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "week_h_checks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "week_holiday_change_id", null: false
    t.string "position", null: false
    t.string "yes_no", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_week_h_checks_on_user_id"
    t.index ["week_holiday_change_id"], name: "index_week_h_checks_on_week_holiday_change_id"
  end

  create_table "week_holiday_changes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.date "original_leave", null: false
    t.date "changed_leave", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_week_holiday_changes_on_user_id"
  end

  add_foreign_key "comments", "holidays"
  add_foreign_key "comments", "users"
  add_foreign_key "remaining_holidays", "users"
  add_foreign_key "requests", "holidays"
  add_foreign_key "requests", "users"
  add_foreign_key "week_h_checks", "users"
  add_foreign_key "week_h_checks", "week_holiday_changes"
end
