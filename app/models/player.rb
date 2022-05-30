class Player < ApplicationRecord
    # Relación
    has_many :games, dependent: :destroy

    # Validación
    validates :name, presence: true
end
