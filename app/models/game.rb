class Game < ApplicationRecord
    # Relaciones
    belongs_to :playerX, class_name: 'Player'
    belongs_to :playerO, class_name: 'Player'

    # Validación
    validates :access_token, uniqueness: true

    #Callback
    before_create :set_access_token

    #Método
    def set_access_token
        self.access_token = SecureRandom.uuid
    end
end
