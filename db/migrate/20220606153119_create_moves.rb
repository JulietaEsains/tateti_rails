class CreateMoves < ActiveRecord::Migration[7.0]
  def change
    create_table :moves do |t|
      t.belongs_to :game, index: true
      t.integer :x
      t.integer :y

      t.timestamps
    end

    add_index :moves, [:x, :y, :game_id], :unique => true
  end
end
