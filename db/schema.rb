
ActiveRecord::Schema.define(version: 2021_01_25_093918) do

  create_table "answers", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.boolean "correct", default: false, null: false
    t.integer "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "questions", force: :cascade do |t|
    t.text "title", null: false
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "theme_id"
    t.index ["author_id"], name: "index_questions_on_author_id"
    t.index ["theme_id"], name: "index_questions_on_theme_id"
  end

  create_table "results", force: :cascade do |t|
    t.integer "question_id"
    t.integer "answer_id"
    t.integer "round_id"
    t.boolean "success", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_results_on_answer_id"
    t.index ["question_id"], name: "index_results_on_question_id"
    t.index ["round_id"], name: "index_results_on_round_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.integer "theme_id"
    t.integer "user_id"
    t.integer "current_answers", default: 0, null: false
    t.integer "wrong_answers", default: 0, null: false
    t.boolean "finished", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "questions_collection", default: "", null: false
    t.index ["theme_id"], name: "index_rounds_on_theme_id"
    t.index ["user_id"], name: "index_rounds_on_user_id"
  end

  create_table "themes", force: :cascade do |t|
    t.string "title", null: false
    t.integer "questions_count", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.string "login", default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
