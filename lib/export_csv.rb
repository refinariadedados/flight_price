
#result = []
#a.each_with_index do |x, i|
#  puts "#{i}\n"
#  output = {}
#  x["Legs"].each_with_index do |legs, leg_index|
#    puts "Leg #{leg_index}\n"
#    output["Arrival_#{leg_index}"] = legs["Arrival"]
#    output["Departure_#{leg_index}"] = legs["Departure"]
#    output["OriginStation_#{leg_index}"] = legs["OriginStation"]
#    output["DestinationStation_#{leg_index}"] = legs["DestinationStation"]
#    output["Carriers_#{leg_index}"] = legs["Carriers"]
#  end
#  x["Agents"].each_with_index do |agent, agent_index|
#    output["Name_Agent_#{agent_index}"] = agent["Name"]
#    output["Type_Agent_#{agent_index}"] = agent["Type"]
#    output["Id_Agent_#{agent_index}"] = agent["Id"]
#  end
#  x["Places"].each_with_index do |place, place_index|
#    output["Code_Place_#{place_index}"] = place["Code"]
#    output["Name_Place_#{place_index}"] = place["Name"]
#    output["Type_Place_#{place_index}"] = place["Type"]
#    output["Id_Place_#{place_index}"] = place["Id"]
#    output["ParentId_Place_#{place_index}"] = place["ParentId"]
#  end
#  x["Itineraries"].each do |itinerarie|
#    output["InboundLegId"] = itinerarie["InboundLegId"]
#    output["OutboundLegId"] = itinerarie["OutboundLegId"]

#    itinerarie["PricingOptions"].each_with_index do |price, price_index|
#      puts "Price #{price_index}\n"
#      output["Price_#{price_index}"] = price["Price"]
#      output["Agents_#{price_index}"] = price["Agents"]
#    end
#  end
#  x["Carriers"].each do |carrier|
#    output["Id_Carrier"] = carrier["Id"]
#    output["Id_Name"] = carrier["Name"]
#  end
#  result << output
#end

#indice = 0
#contagem_de_keys = []

#if result.length > 0
#  while indice < result.length
#    line = {}
#    line["indice_hash"] = indice
#    line["numero_de_chaves"] = result[indice].count
#    contagem_de_keys << line
#    indice += 1
#  end

#  max_keys = contagem_de_keys.max_by{|k|k["numero_de_chaves"]}
#  hash_max_keys = max_keys["indice_hash"]

#  column_names = result[hash_max_keys].keys
#end

#header = column_names
#file_name = "tmp/csv/#{Time.now.to_i}_FlighPrice.csv"

#CSV.open(file_name, "a", write_headers: true, headers: header, force_quotes: true) do |csv|
#  result.each do |row|
#    csv << row.values_at(*header)
#  end
#end

# Conectando local no postgres
conn = PGconn.connect( :hostaddr=>"3.231.55.78", :port=>5432, :dbname=>"fligh_price_development", :user=>"vini", :password=>'123456')
res = conn.exec("SELECT * FROM preco_rota WHERE NOT (content ->> 'Itineraries' = '[]')")

#######################
#### 5 csvs da Karinne
#######################
id = 2616
stop = 0
while stop <= 74581
  id = id+1001
  stop = id +1000
  puts "FROM #{id} TO --> #{stop}\n"
  a = PrecoRota.where.not("content ->> 'Itineraries' = ?", '[]').where(id: id..stop)
  # Legs
  result = []
  a.each_with_index do |x, i|
    puts "#{i}\n"
    x.content["Legs"].each_with_index do |legs, leg_index|
      output = {}
      output["Arrival"] = legs["Arrival"]
      output["Departure"] = legs["Departure"]
      output["OriginStation"] = legs["OriginStation"]
      output["DestinationStation"] = legs["DestinationStation"]
      output["Carriers"] = legs["Carriers"]
      output["Id"] = legs["Id"]
      output["collection_date"] = x.created_at
      result << output
    end
  end
  column_names = result.first.keys
  s = CSV.generate do |csv|
    csv << column_names
    result.each do |x|
    csv << x.values
    end
  end
  File.write("tmp/csv/Legs_#{DateTime.now.strftime("%Y-%m-%d")}_#{id}-#{stop}.csv", s)

  # Agents
  result = []
  a.each_with_index do |x, i|
    puts "#{i}\n"
    x.content["Agents"].each_with_index do |agent, agent_index|
      output = {}
      output["Name"] = agent["Name"]
      output["Type"] = agent["Type"]
      output["Id"] = agent["Id"]
      output["collection_date"] = x.created_at
      result << output
    end
  end

  column_names = result.first.keys
  s = CSV.generate do |csv|
    csv << column_names
    result.each do |x|
    csv << x.values
    end
  end
  File.write("tmp/csv/Agents_#{DateTime.now.strftime("%Y-%m-%d")}_#{id}-#{stop}.csv", s)

  # Places
  result = []
  a.each_with_index do |x, i|
    puts "#{i}\n"
    x.content["Places"].each_with_index do |place, place_index|
      output = {}
      output["Code"] = place["Code"]
      output["Name"] = place["Name"]
      output["Type"] = place["Type"]
      output["Id"] = place["Id"]
      output["ParentId"] = place["ParentId"]
      output["collection_date"] = x.created_at
      result << output
    end
  end

  column_names = result.first.keys
  s = CSV.generate do |csv|
    csv << column_names
    result.each do |x|
    csv << x.values
    end
  end
  File.write("tmp/csv/Places_#{DateTime.now.strftime("%Y-%m-%d")}_#{id}-#{stop}.csv", s)

  # Itineraries
  result = []
  a.each_with_index do |x, i|
    puts "#{i}\n"
    x.content["Itineraries"].each do |itinerarie|
      itinerarie["PricingOptions"].each_with_index do |price, price_index|
        output = {}
        output["InboundLegId"] = itinerarie["InboundLegId"]
        output["OutboundLegId"] = itinerarie["OutboundLegId"]
        output["Price"] = price["Price"]
        output["Agents"] = price["Agents"]
        output["collection_date"] = x.created_at
        result << output
      end
    end
  end

  column_names = result.first.keys
  s = CSV.generate do |csv|
    csv << column_names
    result.each do |x|
    csv << x.values
    end
  end
  File.write("tmp/csv/Itineraries_#{DateTime.now.strftime("%Y-%m-%d")}_#{id}-#{stop}.csv", s)

  # Carriers
  result = []
  a.each_with_index do |x, i|
    x.content["Carriers"].each do |carrier|
      output = {}
      output["Id"] = carrier["Id"]
      output["Name"] = carrier["Name"]
      output["Code"] = carrier["Code"]
      output["collection_date"] = x.created_at
      result << output
    end
  end

  column_names = result.first.keys
  s = CSV.generate do |csv|
    csv << column_names
    result.each do |x|
    csv << x.values
    end
  end
  File.write("tmp/csv/Carriers_#{DateTime.now.strftime("%Y-%m-%d")}_#{id}-#{stop}.csv", s)
end

# Criando feature de export csv diario
a = PrecoRota.where(created_at: "01/09/2021".to_datetime.."01/09/2021".to_datetime.end_of_day).where.not("content ->> 'Itineraries' = ?", '[]')

# Legs
legs_result = []
a.each_with_index do |x, i|
  puts "#{i}\n"
  x.content["Legs"].each_with_index do |legs, leg_index|
    output = {}
    output["Arrival"] = legs["Arrival"]
    output["Departure"] = legs["Departure"]
    output["OriginStation"] = legs["OriginStation"]
    output["DestinationStation"] = legs["DestinationStation"]
    output["Carriers"] = legs["Carriers"].first
    output["Legs_Id"] = legs["Id"]
    #output["collection_date"] = x.created_at
    legs_result << output
  end
end
legs_result.uniq!

# Agents
agents_result = []
a.each_with_index do |x, i|
  puts "#{i}\n"
  x.content["Agents"].each_with_index do |agent, agent_index|
    output = {}
    output["Agents_Name"] = agent["Name"]
    output["Agents_Type"] = agent["Type"]
    output["Agents_Id"] = agent["Id"]
    #output["collection_date"] = x.created_at
    agents_result << output
  end
end
agents_result.uniq!

# Places
places_result = []
a.each_with_index do |x, i|
  puts "#{i}\n"
  x.content["Places"].each_with_index do |place, place_index|
    output = {}
    output["Place_Code"] = place["Code"]
    output["Place_Name"] = place["Name"]
    output["Place_Type"] = place["Type"]
    output["Place_Id"] = place["Id"]
    output["Place_ParentId"] = place["ParentId"]
    #output["collection_date"] = x.created_at
    places_result << output
  end
end
places_result.uniq!

# Itineraries
itineraries_result = []
a.each_with_index do |x, i|
  puts "#{i}\n"
  x.content["Itineraries"].each do |itinerarie|
    itinerarie["PricingOptions"].each_with_index do |price, price_index|
      output = {}
      output["InboundLegId"] = itinerarie["InboundLegId"]
      output["OutboundLegId"] = itinerarie["OutboundLegId"]
      output["Price"] = price["Price"]
      output["Agents"] = price["Agents"].first
      output["collection_date"] = x.created_at
      itineraries_result << output
    end
  end
end

# Carriers
carriers_result = []
a.each_with_index do |x, i|
  x.content["Carriers"].each do |carrier|
    output = {}
    output["Carrier_Id"] = carrier["Id"]
    output["Carrier_Name"] = carrier["Name"]
    output["Carrier_Code"] = carrier["Code"]
    #output["collection_date"] = x.created_at
    carriers_result << output
  end
end
carriers_result.uniq!

