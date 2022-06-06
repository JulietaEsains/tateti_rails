class GamesController < ApplicationController
  before_action :set_game, only: %i[ show update destroy ]
  before_action :set_player_x, except: [:index]
  before_action :check_players_token, except: [:index]

  # GET /games
  def index
    @games = Game.all
    render status: 200, json: {games: @games}
  end

  # GET /games/1
  def show
    render status: 200, json: {game: @game}
  end

  # POST /games
  def create
    @game = @player_x.played_as_x_games.new(game_params)

    if @game.save
      render status: 200, json: {game: @game}
    else
      render status: 400, json: {message: @game.errors.details}
    end
  end

  # PATCH/PUT /games/1
  def update
    if @game.update(game_params)
      render status: 200, json: {game: @game}
    else
      render status: 400, json: {message: @game.errors.details}
    end
  end

  # DELETE /games/1
  def destroy
    if @game.destroy
      render status: 200, json: {message: 'Partida borrada correctamente.'}
    else
      render status: 400, json: {message: @game.errors.details}
    end
  end

  private
    def set_game
      @game = Game.find_by(id: params[:id])
      return if @game.present?

      render status: 404, json: {message: 'No se encontró la partida.'}
      false
    end

    def game_params
      params.require(:game).permit(:board, :x_is_next, :status, :winner, :player_x, :player_o)
    end

    def set_player_x
      @player_x = Player.find_by(id: params[:player_x])
      return if @player_x.present?
  
      render status: 404, json: {message: "No se encontró el jugador X"}
      false
    end

    def check_players_token
      return if request.headers["Authorization"] == "Bearer #{@player_x.access_token}"
  
      render status: 401, json: {message: "No coincide el token de autenticación del jugador"}
      false
    end
end
