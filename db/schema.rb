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

ActiveRecord::Schema.define(version: 20_190_730_004_542) do
  create_table 'jobs', id: :integer, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_jobs_on_user_id'
  end

  create_table 'users', id: :integer, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'first_name'
    t.string 'last_name'
    t.string 'locale', default: 'en'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  create_table 'whitelisted_jwts', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'jti', null: false
    t.string 'aud'
    t.datetime 'exp', null: false
    t.integer 'user_id', null: false
    t.index ['jti'], name: 'index_whitelisted_jwts_on_jti', unique: true
    t.index ['user_id'], name: 'index_whitelisted_jwts_on_user_id'
  end

  create_table 'workflows', id: :integer, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_workflows_on_user_id'
  end

  add_foreign_key 'jobs', 'users'
  add_foreign_key 'whitelisted_jwts', 'users', on_delete: :cascade
  add_foreign_key 'workflows', 'users'
end
