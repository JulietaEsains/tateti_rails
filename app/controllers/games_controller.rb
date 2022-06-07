class GamesController < ApplicationController
  before_action :set_game, only: %i[ show update destroy ]
  before_action :set_player_x, only: %i[ create update destroy ]
  before_action :set_player_o, only: %i[ join update destroy ]
  before_action :check_player_x_token, only: %i[ create update destroy ]
  before_action :check_player_o_token, except: %i[ join update destroy ]

  # GET /games
  def index
    @games = Game.all
    render status: 200, json: {games: @games}
  end

  # GET /games/1
  def show
    render status: 200, json: {game: @game}, :include => [
      :moves => {:except => :game_id}
    ]
  end

  # POST /games
  def create
    @game = @player_x.played_as_x_games.new({})

    if @game.save
      render status: 200, json: {game: @game}
    else
      render status: 400, json: {message: @game.errors.details}
    end
  end

  def join
    @game = @player_o.played_as_o_games.

    if @game.save
      render status: 200, json: {game: @game}
    else
      render status: 400, json: {message: @game.errors.details}
    end

  # PATCH/PUT /games/1
  def update
    new_move = Move.new(x: params[:x], y: params[:y], game_id: game.id)

    begin
      new_move.save

      if new_move.errors.empty? then render status: 200, json: {move: new_move}
      else render status: 400, json: {errors: new_move.errors.details}
      end

    rescue ActiveRecord::RecordNotUnique => e
      render status: 400, json: {errors: {game: ["Movimiento ya realizado sobre el tablero."]}} 
    end
    
  end

  # DELETE /games/1
  def destroy
    if @game.destroy
      render status: 200, json: {message: "Partida borrada correctamente."}
    else
      render status: 400, json: {message: @game.errors.details}
    end
  end

  private
    def set_game
      @game = Game.find_by(id: params[:id])
      return if @game.present?

      render status: 404, json: {message: "No se encontró la partida."}
      false
    end

    def set_player_x
      @player_x = Player.find_by(id: params[:player_x_id]) || @game.player_x
      return if @player_x.present?
  
      render status: 404, json: {message: "No se encontró el jugador X."}
      false
    end

    def set_player_o
      @player_o = Player.find_by(id: params[:player_o_id]) || @game.player_o
      return if @player_o.present?
  
      render status: 404, json: {message: "No se encontró el jugador O."}
      false
    end

    def check_player_x_token
      return if request.headers["Authorization"] == "Bearer #{@player_x.access_token}"
  
      render status: 401, json: {message: "No coincide el token de autenticación del jugador X."}
      false
    end

    def check_player_o_token
      return if request.headers["Authorization"] == "Bearer #{@player_o.access_token}"
  
      render status: 401, json: {message: "No coincide el token de autenticación del jugador O."}
      false
    end
end
