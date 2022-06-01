class Game < ApplicationRecord
    # Relaciones
    belongs_to :player_x, :class_name => 'Player', :foreign_key => 'player_x_id'
    belongs_to :player_o, :class_name => 'Player', :foreign_key => 'player_o_id'

    # Validación
    validates :access_token, uniqueness: true

    #Callback
    before_create :set_access_token

    #Método
    def set_access_token
        self.access_token = SecureRandom.uuid
    end
end
