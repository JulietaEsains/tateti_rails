class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :board, array: true
      t.boolean :x_is_next
      t.string :status
      t.string :winner
      t.belongs_to :player_x, foreign_key: 'player_x_id'
      t.belongs_to :player_o, foreign_key: 'player_o_id'

      t.timestamps
    end
  end
end
