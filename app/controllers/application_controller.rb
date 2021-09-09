class ApplicationController < ActionController::API

  # GET query dates
  def get_dates
    result = {
      outbounddate_60: 60.days.since.next_occurring(:saturday).strftime("%Y-%m-%d"),
      inbounddate_60: 67.days.since.next_occurring(:sunday).strftime("%Y-%m-%d"),
      outbounddate_30: 30.days.since.next_occurring(:saturday).strftime("%Y-%m-%d"),
      inbounddate_30: 37.days.since.next_occurring(:sunday).strftime("%Y-%m-%d")
    }
    render json: result, status: :ok
  end

  # GET body_request
  def get_body
    result = []
    outbounddate_60 = 60.days.since.next_occurring(:saturday).strftime("%Y-%m-%d")
    inbounddate_60 = 68.days.since.next_occurring(:sunday).strftime("%Y-%m-%d")
    outbounddate_30 = 30.days.since.next_occurring(:saturday).strftime("%Y-%m-%d")
    inbounddate_30 = 38.days.since.next_occurring(:sunday).strftime("%Y-%m-%d")

    Trajectory.all.each do |x|
      result << "cabinclass=Economy&country=BR&currency=BRL&locale=pt-BR&locationSchema=iata&originplace=#{x.origin}&destinationplace=#{x.destiny}&outbounddate=#{outbounddate_60}&inbounddate=#{inbounddate_60}&adults=1&children=0&infants=0&apikey=prtl6749387986743898559646983194"
      result << "cabinclass=Economy&country=BR&currency=BRL&locale=pt-BR&locationSchema=iata&originplace=#{x.origin}&destinationplace=#{x.destiny}&outbounddate=#{outbounddate_30}&inbounddate=#{inbounddate_30}&adults=1&children=0&infants=0&apikey=prtl6749387986743898559646983194"
    end
    render json: result
  end

  # POST /transpose
  def transpose_data
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
          agent_type: agent["Type"],
          id_agent: agent["Id"]
        )
      end
      params["Places"].each do |place|
        Place.create(
          code: place["Code"],
          name: place["Name"],
          place_type: place["Type"],
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
      itineraries = []
      params["Itineraries"].each do |itinerarie|
        itineraries << {
          inbound_leg_ig: itinerarie["InboundLegId"],
          outbound_leg_id: itinerarie["OutboundLegId"],
          price: itinerarie["PricingOptions"].map{|e| e.except("DeeplinkUrl", "QuoteAgeInMinutes")},
          created_at: Time.now,
          updated_at: Time.now
        }
      end
      Itinerary.insert_all(itineraries)

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

  private
    # Only allow a list of trusted parameters through.
    def preco_rotum_params
      params.permit()
    end

end

#destinos = ["Rio Branco","Maceió", "Macapá", "Manaus", "Salvador", "Fortaleza", "Brasília", "Vitória", "Goiânia", "São Luís", "Cuiabá", "Campo Grande", "Belo Horizonte", "Belém", "João Pessoa", "Curitiba", "Recife", "Teresina", "Rio de Janeiro", "Natal", "Porto Alegre", "Porto Velho", "Boa Vista", "Florianópolis", "São Paulo", "Aracaju", "Palmas"]
#aux = ["Aracaju" , "Brasília", "Belém", "Belo Horizonte", "Campo Grande", "Curitiba", "Fortaleza", "Goiânia", "Porto Alegre", "Recife", "Rio Branco", "Rio de Janeiro", "Salvador", "São Luís", "São Paulo", "Vitória"]
#origens = Airport.where("city_name = any(array[?])", aux)

#result = []
#origens.each do |origin|
#  list = destinos - [origin.city_name]
#  Airport.where("city_name = any(array[?])", list).each do |destiny|
#    line= {}
#    line["origem"] = origin.airport_id
#    line["origem_nome"] = origin.airport_name
#    line["destino"] = destiny.airport_id
#    line["destino_nome"] = destiny.airport_name
#    result << line
#  end
#end
