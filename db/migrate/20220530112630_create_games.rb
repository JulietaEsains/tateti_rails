class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :access_token
      t.string :board, array: true
      t.boolean :x_is_next, default: true
      t.string :winner
      t.belongs_to :player_x, class_name: 'Player'
      t.belongs_to :player_o, class_name: 'Player'

      t.timestamps
    end
  end
end
