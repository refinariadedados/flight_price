# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_03_124158) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agents", force: :cascade do |t|
    t.string "name"
    t.string "agent_type"
    t.string "id_agent"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "airport_ids", force: :cascade do |t|
    t.string "airport_name"
    t.string "city_id"
    t.string "airport_coordinates"
    t.string "city_name"
    t.string "city_coordinates"
    t.string "iata_code"
    t.string "country_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "airports", force: :cascade do |t|
    t.string "airport_id"
    t.string "airport_name"
    t.string "city_id"
    t.string "airport_coordinates"
    t.string "city_name"
    t.string "city_coordinates"
    t.string "iata_code"
    t.string "country_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "carriers", force: :cascade do |t|
    t.string "carrier_id"
    t.string "name"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "itineraries", force: :cascade do |t|
    t.string "inbound_leg_ig"
    t.string "outbound_leg_id"
    t.jsonb "price"
    t.string "agent"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "legs", force: :cascade do |t|
    t.string "arrival"
    t.string "departure"
    t.string "origin_station"
    t.string "destination_station"
    t.string "carrier"
    t.string "id_leg"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "places", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "place_type"
    t.string "place_id"
    t.string "parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "preco_rota", force: :cascade do |t|
    t.jsonb "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trajectories", force: :cascade do |t|
    t.string "origin"
    t.string "destiny"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
