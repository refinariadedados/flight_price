a = PrecoRota.where.not("content ->> 'Itineraries' = ?", '[]').first(1000).pluck(:content)

result = []
a.each_with_index do |x, i|
  puts "#{i}\n"
  output = {}
  x["Legs"].each_with_index do |legs, leg_index|
    puts "Leg #{leg_index}\n"
    output["Arrival_#{leg_index}"] = legs["Arrival"]
    output["Departure_#{leg_index}"] = legs["Departure"]
    output["OriginStation_#{leg_index}"] = legs["OriginStation"]
    output["DestinationStation_#{leg_index}"] = legs["DestinationStation"]
    output["Carriers_#{leg_index}"] = legs["Carriers"]
  end
  x["Agents"].each_with_index do |agent, agent_index|
    output["Name_Agent_#{agent_index}"] = agent["Name"]
    output["Type_Agent_#{agent_index}"] = agent["Type"]
    output["Id_Agent_#{agent_index}"] = agent["Id"]
  end
  x["Places"].each_with_index do |place, place_index|
    output["Code_Place_#{place_index}"] = place["Code"]
    output["Name_Place_#{place_index}"] = place["Name"]
    output["Type_Place_#{place_index}"] = place["Type"]
    output["Id_Place_#{place_index}"] = place["Id"]
  end
  x["Itineraries"].each do |itinerarie|
    itinerarie["PricingOptions"].each_with_index do |price, price_index|
      puts "Price #{price_index}\n"
      output["Price_#{price_index}"] = price["Price"]
      output["Agents_#{price_index}"] = price["Agents"]
    end
  end
  result << output
end

indice = 0
contagem_de_keys = []

if result.length > 0
  while indice < result.length
    line = {}
    line["indice_hash"] = indice
    line["numero_de_chaves"] = result[indice].count
    contagem_de_keys << line
    indice += 1
  end

  max_keys = contagem_de_keys.max_by{|k|k["numero_de_chaves"]}
  hash_max_keys = max_keys["indice_hash"]

  column_names = result[hash_max_keys].keys
end

header = column_names
file_name = "tmp/#{Time.now.to_i}_FlighPrice.csv"

CSV.open(file_name, "a", write_headers: true, headers: header, force_quotes: true) do |csv|
  result.each do |row|
    csv << row.values_at(*header)
  end
end

