class Game < ApplicationRecord
    # Relaciones
    belongs_to :player_x, class_name: "Player", foreign_key: "player_x_id"
    belongs_to :player_o, class_name: "Player", foreign_key: "player_o_id"
    has_many :moves, dependent: :destroy

    # Métodos
    def get_board
        board = Array.new(3){Array.new(3, " ")}

        self.moves.each_with_index do |move, i|
            board[move.y][move.x] = (i % 2 == 0) ? "X" : "O"
        end

        board
    end

    def get_winner
        board = self.get_board()
    
        # Tres horizontal
        board.each do |row|
          next if row[0] == " "
          if row.uniq.length == 1 then return row.uniq.first end
        end
    
        # Tres vertical
        board.transpose.each do |col|
          next if col[0] == " "
          if col.uniq.length == 1 then return col.uniq.first end
        end
    
        # Tres diagonal
        if board[0][0] != " " and 
           board[0][0] == board[1][1] and 
           board[1][1] == board[2][2] then
           return board[0][0]
        end
    
        if board[2][0] != " " and
           board[2][0] == board[1][1] and
           board[1][1] == board[0][2] then
           return board[2][0]
        end
    
        return nil
    end

    def is_finished?
        if self.get_winner != nil or self.moves.count == 9
            return true
        else
            return false
        end
    end
end
