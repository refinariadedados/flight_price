itineraries_result = []
a["Itineraries"].each do |itinerarie|
  itinerarie["PricingOptions"].each_with_index do |price, price_index|
    output = {}
    output["InboundLegId"] = itinerarie["InboundLegId"]
    output["OutboundLegId"] = itinerarie["OutboundLegId"]
    output["Price"] = price["Price"]
    output["Agents"] = price["Agents"].first
    #output["collection_date"] = x.created_at
    itineraries_result << output
  end
end

itineraries_result.each do |itinerarie|

  outboundlegid = itinerarie["OutboundLegId"]

  legs_result = a["Legs"].select{|e| e["Id"] == outboundlegid}

  legs_result.each do |leg|
    Model.new(
      origin_name: a["Places"].select{|x| x["Id"] == leg["OriginStation"]}.first["Name"],
      origin_code: a["Places"].select{|x| x["Id"] == leg["OriginStation"]}.first["Code"],
      origin_type: a["Places"].select{|x| x["Id"] == leg["OriginStation"]}.first["Type"],
      origin_id: a["Places"].select{|x| x["Id"] == leg["OriginStation"]}.first["Id"],
      destiny_name: a["Places"].select{|x| x["Id"] == leg["DestinationStation"]}.first["Name"],
      destiny_code: a["Places"].select{|x| x["Id"] == leg["DestinationStation"]}.first["Code"],
      destiny_type: a["Places"].select{|x| x["Id"] == leg["DestinationStation"]}.first["Type"],
      destiny_id: a["Places"].select{|x| x["Id"] == leg["DestinationStation"]}.first["Id"],
      
    )

   # origin_station << a["Places"].select{|x| x["Id"] == leg["OriginStation"]}.first
   # destination_station << a["Places"].select{|x| x["Id"] == leg["DestinationStation"]}.first

  end

end

a = PrecoRota.where.not("content ->> 'Itineraries' = ?", '[]').where(id: id..stop)
# Legs
a.each_with_index do |x, i|
  puts "#{i}\n"
  x.content["Legs"].each_with_index do |legs, leg_index|
    Leg.create(
      arrival: legs["Arrival"],
      departure: legs["Departure"],
      origin_station: legs["OriginStation"],
      destination_station: legs["DestinationStation"],
      carriers: = legs["Carriers"].first,
      id_leg: = legs["Id"],
    )
  end
  x.content["Agents"].each_with_index do |agent, agent_index|
    Agent.create(
      name: agent["Name"],
      type: agent["Type"],
      id_agent: agent["Id"]
    )
  end
  x.content["Places"].each_with_index do |place, place_index|
    Place.create(
      code: place["Code"],
      name: place["Name"],
      type: place["Type"],
      place_id: place["Id"],
      parent_id: place["ParentId"]
    )
  end
  x.content["Carriers"].each do |carrier|
    Carrier.create(
      carrier_id: carrier["Id"],
      name: carrier["Name"],
      code: carrier["Code"]
    )
  end
  x.content["Itineraries"].each do |itinerarie|
    itinerarie["PricingOptions"].each_with_index do |price, price_index|
      aux = Itinerarie.create(
        inboundlegid: itinerarie["InboundLegId"],
        outboundlegid: itinerarie["OutboundLegId"],
        price: price["Price"],
        agents: price["Agents"].first
      )
    end
  end
end

# Lógica no POST /preco_rota
params["Legs"].each do |legs|
  Leg.create(
    arrival: legs["Arrival"],
    departure: legs["Departure"],
    origin_station: legs["OriginStation"],
    destination_station: legs["DestinationStation"],
    carriers: = legs["Carriers"].first,
    id_leg: = legs["Id"],
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
  itinerarie["PricingOptions"].each do |price|
    aux = Itinerarie.create(
      inboundlegid: itinerarie["InboundLegId"],
      outboundlegid: itinerarie["OutboundLegId"],
      price: price["Price"],
      agents: price["Agents"].first
    )
  end
end

Itinerary.where(created_at: 1.days.ago.beginning_of_day..1.days.ago.end_of_day).each do |iti|
  legs = Leg.where(id: it.outboundlegid)
  legs.each do |leg|
    carrier = Carrier.find(id: leg.carriers)
    agent = Agent.find(id: iti.agents)
    place_origin = Place.find(id: leg.origin_station)
    place_destination = Place.find(id: leg.destination_station)
    Summarise.create(
      price: iti.price,
      arrival: leg.arrival,
      departure: leg.departure,
      carriers_name: carrier.name,
      carriers_code: carrier.code,
      agents_name: agent.name,
      agents_type: agent.type,
      place_code_origin: place_origin.code,
      place_name_origin: place_origin.name,
      place_type_origin: place_origin.type,
      place_code_destination: place_destination.code,
      place_name_destination: place_destination.name,
      place_type_destination: place_destination.type
    )
  end
end
