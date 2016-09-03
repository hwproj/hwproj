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

ActiveRecord::Schema.define(version: 20160903073618) do

  create_table "awards", force: true do |t|
    t.integer  "job_id"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "awards", ["job_id"], name: "index_awards_on_job_id"

  create_table "courses", force: true do |t|
    t.string   "name"
    t.string   "group_name"
    t.integer  "teacher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     default: true
  end

  create_table "homeworks", force: true do |t|
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.integer  "term_id"
    t.integer  "assignment_type"
    t.boolean  "done",            default: false
    t.boolean  "active",          default: true
  end

  add_index "homeworks", ["term_id", "id"], name: "index_homeworks_on_term_id_and_id"

  create_table "invitations", force: true do |t|
    t.string   "email"
    t.string   "digest"
    t.boolean  "active",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invitations", ["email"], name: "index_invitations_on_email"

  create_table "jobs", force: true do |t|
    t.boolean  "done",        default: false
    t.integer  "homework_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "student_id"
  end

  add_index "jobs", ["student_id"], name: "index_jobs_on_student_id"

  create_table "links", force: true do |t|
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "parent_id"
    t.string   "parent_type"
  end

  add_index "links", ["parent_id", "id"], name: "index_links_on_parent_id_and_id"
  add_index "links", ["parent_id", "parent_type"], name: "index_links_on_parent_id_and_parent_type"

  create_table "notes", force: true do |t|
    t.boolean  "fixed",                     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "submission_id"
    t.text     "text",          limit: 255
  end

  create_table "notifications", force: true do |t|
    t.integer  "submission_id"
    t.integer  "task_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_type"
  end

  add_index "notifications", ["submission_id"], name: "index_notifications_on_submission_id"
  add_index "notifications", ["task_id"], name: "index_notifications_on_task_id"
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id"

  create_table "problems", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "homework_id"
    t.text     "text",        limit: 255
    t.integer  "number"
    t.string   "name"
  end

  add_index "problems", ["homework_id", "id"], name: "index_problems_on_homework_id_and_id"
  add_index "problems", ["homework_id"], name: "index_problems_on_homework_id"

  create_table "students", force: true do |t|
    t.integer  "user_id"
    t.integer  "term_id"
    t.boolean  "approved",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tasks_left_count", default: 0,     null: false
  end

  create_table "submissions", force: true do |t|
    t.text     "text",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "task_id"
    t.integer  "user_id"
    t.string   "file"
    t.integer  "version"
    t.integer  "student_id"
    t.integer  "teacher_id"
    t.string   "url"
    t.boolean  "pull_request",               default: false
    t.integer  "comments_count",             default: 0
  end

  add_index "submissions", ["task_id"], name: "index_submissions_on_task_id"

  create_table "tasks", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "problem_id"
    t.integer  "status",         default: 0
    t.integer  "homework_id"
    t.integer  "job_id"
    t.integer  "student_id"
    t.integer  "problem_number"
  end

  add_index "tasks", ["job_id", "problem_number"], name: "index_tasks_on_job_id_and_problem_number"
  add_index "tasks", ["job_id"], name: "index_tasks_on_job_id"
  add_index "tasks", ["problem_id"], name: "index_tasks_on_problem_id"
  add_index "tasks", ["user_id", "status"], name: "index_tasks_on_user_id_and_status"

  create_table "terms", force: true do |t|
    t.integer  "course_id"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     default: true
  end

  add_index "terms", ["course_id"], name: "index_terms_on_course_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "surname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "user_type",              default: 0
    t.integer  "group_id"
    t.integer  "gender"
    t.boolean  "approved",               default: false
    t.string   "github_access_token"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
