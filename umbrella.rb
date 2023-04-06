

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
parsed_pirate_weather_data = JSON.parse(pirate_raw_response)

current_weather = parsed_pirate_weather_data.fetch("currently")
temp = current_weather.fetch("temperature")
humidity = current_weather.fetch("humidity")
summary = current_weather.fetch("summary")
rain = current_weather.fetch("precipProbability")

p "It is currently #{summary} and #{temp} degress outside with a humidity of #{humidity}. There is a #{rain} percent chance of rain."

minutely_hash = parsed_pirate_weather_data.fetch("minutely", false)
if minutely_hash
  next_hour_summary = minutely_hash.fetch("summary")

  puts "Next hour: #{next_hour_summary}"
end

hourly_hash = parsed_pirate_weather_data.fetch("hourly", false)
if hourly_hash
  day_hash = hourly_hash.fetch("summary", false)

  puts "Next 12 hours: #{day_hash}"
end



hourly_rain = parsed_pirate_weather_data.fetch("hourly")
hourly_array = hourly_rain.fetch("data")

day_summary = hourly_array[1..12]

precip_acceptance_level = 0.10

threshold = false

day_summary.each do |hourly_hash|

min_rain_probability = hourly_hash.fetch("precipProbability")

if precip_prob > precip_prob_threshold
  its_gon_rain = true

  
