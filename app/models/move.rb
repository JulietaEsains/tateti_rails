class Move < ApplicationRecord
    # Relaciones
    belongs_to :game

    # Validaciones
    validates :x,
        inclusion: {in: 0..2, message: "Debe ser 0, 1 o 2"},
        presence: true

    validates :y,
        inclusion: {in: 0..2, message: "Debe ser 0, 1 o 2"},
        presence: true
    
    validate :game_is_not_finished

    # Métodos
    def readonly?
        !new_record?
    end

    def game_is_not_finished
        if self.game.is_finished?
            errors.add(:game, "El juego ha terminado")
        end
    end
end
