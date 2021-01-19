require "discordrb"
require 'rest-client'
require 'json'

def tell_me_a_random_pokemon ()
  response = RestClient.get("https://pokeapi.co/api/v2/pokemon/#{rand 251}")
  results = JSON.parse(response.to_str)
  name = (results['forms'][0]['name']).capitalize!
  image = results['sprites']['front_default']
  arr = [name,image]
  return arr
end

@my_bot = Discordrb::Bot.new token: ENV['TOKEN']

@my_bot.message(with_text: 'Ping!') do |event|
  event.respond 'Pong!'
end

@my_bot.message(with_text: 'decime algun pokemon') do |event|
  arr = tell_me_a_random_pokemon()
  event.respond "#{arr[0]} #{arr[1]}"
end

@my_bot.run

