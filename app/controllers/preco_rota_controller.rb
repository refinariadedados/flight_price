class PrecoRotaController < ApplicationController
  before_action :set_preco_rotum, only: [:show, :update, :destroy]

  # GET /preco_rota
  def index
    @preco_rota = PrecoRota.all

    render json: @preco_rota
  end

  # GET /preco_rota/1
  def show
    render json: @preco_rotum
  end

  # POST /preco_rota
  def create
    @preco_rotum = PrecoRota.new(content: params)
    #byebug
    if @preco_rotum.save
      render json: @preco_rotum, status: :created, location: @preco_rotum
    else
      render json: @preco_rotum.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /preco_rota/1
  #def update
    #if @preco_rotum.update(preco_rotum_params)
    #  render json: @preco_rotum
    #else
    #  render json: @preco_rotum.errors, status: :unprocessable_entity
    #end
  #end

  # DELETE /preco_rota/1
  def destroy
    @preco_rotum.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_preco_rotum
      @preco_rotum = PrecoRota.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def preco_rotum_params
      params.permit()
    end
end
