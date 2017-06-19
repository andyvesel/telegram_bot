require 'telegram_bot'
require 'pp'
require 'logger'
require 'rbing'

logger = Logger.new(STDOUT, Logger::DEBUG)

bot = TelegramBot.new(token: '395303980:AAEhCl_PPRFm8shHR56XW5mVgOqClKUfdBw', logger: logger)

bing = RBing.new('59fd63b3eb314706b4440cdd6438533f')
query = "tits"
results = bing.web("#{query} site:google.com")
puts results

bot.get_updates(fail_silently: true) do |message|

  logger.info "@#{message.from.username}: #{message.text}"
  command = message.get_command_for(bot)

  message.reply do |reply|
    case command
    when /get/i
      reply.text = "Hello, #{message.from.first_name}!"
    else

      reply.text = "#{message.from.first_name}, have no idea what #{command.inspect} means."
    end
    logger.info "sending #{reply.text.inspect} to @#{message.from.username}"
    reply.send_with(bot)

  end
end
