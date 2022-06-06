class PlayersController < ApplicationController
  before_action :set_player, only: %i[ show update destroy ]
  before_action :check_token, only: %i[ update destroy ]

  # GET /players
  def index
    @players = Player.all
    render status: 200, json: {players: @players}
  end

  # GET /players/1
  def show
    render status: 200, json: {player: @player}
  end

  # POST /players
  def create
    @player = Player.new(player_params)

    if @player.save
      render status: 200, json: {player: @player}
    else
      render status: 400, json: {message: @player.errors.details}
    end
  end

  # PATCH/PUT /players/1
  def update
    if @player.update(player_params)
      render status: 200, json: {player: @player}
    else
      render status: 400, json: {message: @player.errors.details}
    end
  end

  # DELETE /players/1
  def destroy
    if @player.destroy
      render status: 200, json: {message: 'Jugador borrado correctamente.'}
    else 
      render status: 400, json: {message: @player.errors.details}
    end
  end

  private
    def set_player
      @player = Player.find_by(id: params[:id])
      return if @player.present?

      render status: 404, json: {message: 'No se encontró el jugador.'}
      false
    end

    def player_params
      params.require(:player).permit(:name)
    end

    def check_token
      return if request.headers["Authorization"] == "Bearer #{@player.access_token}"
  
      render status: 401, json: {message: "No coincide el token de autenticación"}
      false
    end
end
