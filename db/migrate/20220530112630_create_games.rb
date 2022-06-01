class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :access_token
      t.string :board, array: true
      t.boolean :x_is_next
      t.string :status
      t.string :winner
      t.belongs_to :player_x, :class_name => 'Player', :foreign_key => 'player_x_id'
      t.belongs_to :player_o, :class_name => 'Player', :foreign_key => 'player_o_id'

      t.timestamps
    end
  end
end
