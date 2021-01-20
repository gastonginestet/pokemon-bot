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
  event.channel.send_embed do |embed|
    embed.title = "#{arr[0]}"
    embed.colour = 0xcc0000
    embed.image = Discordrb::Webhooks::EmbedImage.new(url: "#{arr[1]}")
  end
end

@my_bot.run