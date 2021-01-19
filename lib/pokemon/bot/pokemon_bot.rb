require "discordrb/webhooks"
require "date"

WEBHOOK_URL = 'YOUR_WEBHOOK_URL'.freeze

client = Discordrb::Webhooks::Client.new(url: WEBHOOK_URL)

loop do
  now = DateTime.now
  yesterday = DateTime.new(now.year, now.month, 14, 16, 30, 0, now.zone)
  reminder = DateTime.new(now.year, now.month, now.day, 16, 30, 0, now.zone)

  if (now.hour == reminder.hour) && (now.minute == reminder.minute)
    client.execute do |builder|
      builder.content = "Buenas Snapplxrs!!!"
      builder.add_embed do |embed|
        embed.title = "Bot-Recordatorio de clase"
        embed.description = "en media hora tenemos la clase"
        embed.timestamp = Time.now
        embed.image = Discordrb::Webhooks::EmbedImage.new(url: "https://i.pinimg.com/564x/6e/e1/ea/6ee1eac6dac0c865d99eba741bbc7338.jpg")
      end
    end
    break
  else
    p "todavia no"
    p "hoy es #{now}"
  end
  sleep 1
end
