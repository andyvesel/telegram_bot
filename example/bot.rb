require 'telegram_bot'
require 'pp'
require 'logger'
require 'elasticsearch'

logger = Logger.new(STDOUT, Logger::DEBUG)

bot = TelegramBot.new(token: '395303980:AAEhCl_PPRFm8shHR56XW5mVgOqClKUfdBw', logger: logger)
client = Elasticsearch::Client.new log: true
logger.info client
logger.debug "starting telegram bot"

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
