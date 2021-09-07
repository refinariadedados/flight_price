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
    # byebug
    if params["Itineraries"] != []
      # Cria os carinha separadamente
      params["Legs"].each do |legs|
        Leg.create(
          arrival: legs["Arrival"],
          departure: legs["Departure"],
          origin_station: legs["OriginStation"],
          destination_station: legs["DestinationStation"],
          carrier: legs["Carriers"].first,
          id_leg: legs["Id"],
        )
      end
      params["Agents"].each do |agent|
        Agent.create(
          name: agent["Name"],
          type: agent["Type"],
          id_agent: agent["Id"]
        )
      end
      params["Places"].each do |place|
        Place.create(
          code: place["Code"],
          name: place["Name"],
          type: place["Type"],
          place_id: place["Id"],
          parent_id: place["ParentId"]
        )
      end
      params["Carriers"].each do |carrier|
        Carrier.create(
          carrier_id: carrier["Id"],
          name: carrier["Name"],
          code: carrier["Code"]
        )
      end
      params["Itineraries"].each do |itinerarie|
        Itinerary.create(
          inbound_leg_ig: itinerarie["InboundLegId"],
          outbound_leg_id: itinerarie["OutboundLegId"],
          price: itinerarie["PricingOptions"].map{|e| e.except("DeeplinkUrl", "QuoteAgeInMinutes")}
        )
      end
      # Como vamos juntar depois só deus sabe
      #@preco_rotum = PrecoRota.new(content: params)
      # byebug
      render json: {msg: "Trem feito", status: :created}
      #if @preco_rotum.save
      #  render json: @preco_rotum, status: :created, location: @preco_rotum
      #else
      #  render json: @preco_rotum.errors, status: :unprocessable_entity
      #end
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
