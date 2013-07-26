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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130212122134) do

  create_table "agent_status", :force => true do |t|
    t.integer  "user_id"
    t.integer  "claim_id"
    t.string   "from"
    t.string   "to"
    t.string   "subject"
    t.string   "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "answers", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "question_id"
  end

  create_table "claims", :force => true do |t|
    t.string   "policy_number"
    t.date     "date_of_loss"
    t.string   "location_of_loss"
    t.string   "claim_description"
    t.string   "damage_details"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "policy_document"
    t.string   "damage_photo"
    t.integer  "policy_worth"
    t.integer  "monthly_premium"
    t.boolean  "is_home_or_any_part_lent_or_sublet"
    t.string   "lent_or_sublet_description"
    t.date     "damage_discovered_date"
    t.string   "discovered_by"
    t.date     "property_last_seen"
    t.string   "property_last_seen_by"
    t.date     "time_of_police_notified"
    t.string   "police_reference"
    t.boolean  "have_made_any_claim_before"
    t.string   "claim_settlement_details"
    t.boolean  "are_you_owner_of_lost"
    t.string   "state_the_names_owner"
    t.boolean  "occupied_home_as_tenant"
    t.boolean  "are_you_responsible_for_tenancy_agreement"
    t.string   "limit_of_responsibility"
    t.boolean  "have_estimates"
    t.integer  "estimated_cost_of_repair"
    t.integer  "actual_cost"
    t.integer  "claiming_cost"
    t.integer  "claim_number"
    t.integer  "customer_id"
    t.integer  "agent_id"
    t.string   "claim_status"
    t.boolean  "is_damage_occur_your_home"
    t.string   "damage_at_home_description_details"
    t.boolean  "are_you_registered_for_VAT"
    t.boolean  "are_estimates_sent_late_date"
  end

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "damage_photos", :force => true do |t|
    t.string   "file"
    t.integer  "damageattachable_id"
    t.string   "damageattachable_type"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "end_users", :force => true do |t|
    t.string   "first_name",          :limit => 50
    t.string   "last_name",           :limit => 50
    t.string   "email",               :limit => 35
    t.string   "user_name"
    t.date     "dob"
    t.string   "mobile"
    t.string   "gender"
    t.string   "location"
    t.string   "address"
    t.integer  "zip"
    t.string   "policy_number"
    t.string   "damage_details"
    t.date     "date_of_damage"
    t.integer  "role_id"
    t.integer  "agent_id"
    t.boolean  "claims_status",                     :default => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "image"
    t.string   "policy_company_name"
  end

  create_table "items", :force => true do |t|
    t.string   "description"
    t.string   "age_of_item"
    t.integer  "price_paid"
    t.integer  "estimated_cost"
    t.integer  "replacement_cost"
    t.integer  "deductions_for_wear_and_tear"
    t.integer  "amount_claimed"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "claim_id"
  end

  create_table "policy_photos", :force => true do |t|
    t.integer  "claim_id"
    t.string   "file"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "qoutations", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "questions", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
  end

  create_table "quotations", :force => true do |t|
    t.string   "quotation"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "role"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sentstatuses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "claim_id"
    t.string   "from"
    t.string   "to"
    t.string   "subject"
    t.string   "message"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "customer_id"
    t.integer  "agent_id"
    t.boolean  "is_viewed"
    t.boolean  "is_agent_viewed"
    t.boolean  "is_customer_viewed"
  end

  create_table "user_claims", :force => true do |t|
    t.integer  "user_id"
    t.integer  "claim_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_mails", :force => true do |t|
    t.string   "from"
    t.string   "to"
    t.string   "subject"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "message"
  end

  create_table "user_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.string   "user_name"
    t.integer  "emp_id"
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "completed_status",                      :default => false
    t.string   "first_name",             :limit => 50
    t.string   "last_name",              :limit => 50
    t.date     "dob"
    t.string   "mobile"
    t.string   "gender"
    t.string   "location"
    t.string   "address"
    t.integer  "zip"
    t.date     "completed_at"
    t.boolean  "approved_status"
    t.boolean  "claim_status"
    t.integer  "agent_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
