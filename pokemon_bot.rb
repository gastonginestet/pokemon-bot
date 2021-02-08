require 'discordrb'
require 'rest-client'
require 'json'

def tell_me_a_random_pokemon
  response = RestClient.get("https://pokeapi.co/api/v2/pokemon/#{rand 251}")
  results = JSON.parse(response.to_str)
  name = (results['forms'][0]['name']).capitalize!
  image = results['sprites']['front_default']
  type = results['types'][0]['type']['name']
  id = results['id']
  [name, image, type, id]
end

def get_colour(type)
  File.open('types.json', 'r') do |file|
    colours = JSON.parse(file.read)
    colours[type]
  end
end

@my_bot = Discordrb::Bot.new token: ENV['TOKEN']

@my_bot.message(with_text: 'Ping!') do |event|
  event.respond 'Pong!'
end

@my_bot.message(with_text: 'decime algun pokemon') do |event|
  arr = tell_me_a_random_pokemon()
  event.channel.send_embed do |embed|
    embed.author = { name: "ID: #{arr[3]}" }
    embed.title = arr[0].to_s
    embed.description = "Type: #{arr[2].to_s.capitalize}"
    embed.colour = get_colour(arr[2])
    embed.footer = { text: '«PokeBot»' }
    embed.image = Discordrb::Webhooks::EmbedImage.new(url: arr[1].to_s)
  end
end

@my_bot.run
