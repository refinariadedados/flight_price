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
