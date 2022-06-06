class Player < ApplicationRecord
    # Relaciones
    has_many :played_as_x_games, class_name: 'Game', dependent: :destroy
    has_many :played_as_o_games, class_name: 'Game', dependent: :destroy

    # Validaciones
    validates :name, presence: true
    validates :access_token, uniqueness: true

    # Callback
    before_create :set_access_token

    # Método
    def set_access_token
        self.access_token = SecureRandom.uuid
    end
end
