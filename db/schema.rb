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

ActiveRecord::Schema.define(version: 2018_07_22_000002) do

  create_table              "networks", force: :cascade do |t|
      t.string              "name"

      t.string              "network_cidr"
      t.string              "shared_subnet_cidr"
      t.string              "protected_subnet_cidr"

      t.string              "network_id"
      t.string              "shared_subnet_id"
      t.string              "protected_subnet_id"
      t.string              "az_id"
      t.integer             "templates_id"
      t.datetime            "created_at", null: false
      t.datetime            "updated_at", null: false
      t.index               ["templates_id"], name: "index_networks_on_templates_id"
  end

  create_table              "hipswitches", force: :cascade do |t|
    t.string                "name"
    t.string                "image_id"
    t.string                "machine_type_id"
    t.string                "shared_subnet_id"
    t.string                "protected_subnet_id"
    t.string                "conductor_id"
    t.string                "az_id"
    t.integer               "templates_id"
    t.datetime              "created_at", null: false
    t.datetime              "updated_at", null: false
    t.index                 ["templates_id"], name: "index_hipswitches_on_templates_id"
  end

  create_table              "hosts", force: :cascade do |t|
    t.string                "name"
    t.string                "image_id"
    t.string                "machine_type_id"
    t.string                "protected_subnet_id"
    t.text                  "custom_application"
    t.integer               "templates_id"
    t.datetime              "created_at", null: false
    t.datetime              "updated_at", null: false
    t.index                 ["templates_id"], name: "index_hosts_on_templates_id"
  end

  create_table              "templates", force: :cascade do |t|
    t.string                "name"
    t.text                  "description"
    t.string                "regions"
    t.string                "deployments"
    t.string                "hosts"
    t.datetime              "available_at"
    t.datetime              "created_at", null: false
    t.datetime              "updated_at", null: false
  end

end
