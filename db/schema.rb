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

ActiveRecord::Schema[7.0].define(version: 2022_06_06_153119) do
  create_table "games", force: :cascade do |t|
    t.integer "player_x_id"
    t.integer "player_o_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_o_id"], name: "index_games_on_player_o_id"
    t.index ["player_x_id"], name: "index_games_on_player_x_id"
  end

  create_table "moves", force: :cascade do |t|
    t.integer "game_id"
    t.integer "x"
    t.integer "y"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_moves_on_game_id"
    t.index ["x", "y", "game_id"], name: "index_moves_on_x_and_y_and_game_id", unique: true
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "access_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "games", "player_os"
  add_foreign_key "games", "player_xes"
end
