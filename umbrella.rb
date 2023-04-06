

p "Where are you located?"
# user_location = gets.chomp
user_location = "Chicago"

p user_location 

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{ENV.fetch("GMAPS_KEY")}"

p gmaps_url

require "open-uri"
raw_response = URI.open(gmaps_url).read

require "json"
parsed_response = JSON.parse(raw_response)

results_array = parsed_response.fetch("results")

first_result = results_array.at(0)

geo = first_result.fetch("geometry")

loc = geo.fetch("location")

latitude = loc.fetch("lat")

longitude = loc.fetch("lng")

p latitude
p longitude

pirate_weather_url = "https://api.pirateweather.net/forecast/#{ENV.fetch("PIRATE_WEATHER_KEY")}/#{latitude},#{longitude}"

pirate_raw_response = URI.open(pirate_weather_url).read

parsed_pirate_weather_data = JSON.parse
