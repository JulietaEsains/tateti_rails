class Player < ApplicationRecord
    # Relación
    has_many :played_as_x_games, :class_name => 'Game', :foreign_key => 'player_x_id'
    has_many :played_as_o_games, :class_name => 'Game', :foreign_key => 'player_o_id'

    # Validación
    validates :name, presence: true
end
