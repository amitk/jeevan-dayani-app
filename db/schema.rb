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

ActiveRecord::Schema.define(version: 2020_07_01_114145) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clinics", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.string "state"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clinics_doctors", id: false, force: :cascade do |t|
    t.bigint "clinic_id", null: false
    t.bigint "doctor_id", null: false
    t.index ["clinic_id", "doctor_id"], name: "index_clinics_doctors_on_clinic_id_and_doctor_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "name", null: false
    t.string "specialization", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "drugs", force: :cascade do |t|
    t.string "name", null: false
    t.string "target_ailment", null: false
    t.string "side_effects", default: [], array: true
    t.bigint "pharma_company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pharma_company_id"], name: "index_drugs_on_pharma_company_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string "state", null: false
    t.bigint "patient_id"
    t.bigint "trial_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_feedbacks_on_patient_id"
    t.index ["trial_id"], name: "index_feedbacks_on_trial_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.string "sex"
    t.bigint "trial_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trial_id"], name: "index_patients_on_trial_id"
  end

  create_table "pharma_companies", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trial_configurations", force: :cascade do |t|
    t.string "name", default: ""
    t.bigint "drug_id"
    t.bigint "doctor_id"
    t.bigint "clinic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clinic_id"], name: "index_trial_configurations_on_clinic_id"
    t.index ["doctor_id"], name: "index_trial_configurations_on_doctor_id"
    t.index ["drug_id"], name: "index_trial_configurations_on_drug_id"
  end

  create_table "trials", force: :cascade do |t|
    t.string "name"
    t.integer "phase", default: 1
    t.string "status", default: "active"
    t.bigint "trial_configuration_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trial_configuration_id"], name: "index_trials_on_trial_configuration_id"
  end

end
