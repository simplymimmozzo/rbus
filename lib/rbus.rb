require "rbus/version"

module Rbus
  class Bus

    @handlers

    def initialize
      @handlers = Hash.new
    end

    def add_handler(message_type, handler)
      @handlers[message_type.name] = [] unless @handlers[message_type.name]
      @handlers[message_type.name] << handler
    end

    def publish(message)
      return if !@handlers[message.class.name]
      handlers = @handlers[message.class.name]
      return if handlers.count == 0
      handlers.each do |handler|
        handler.handle message
      end
    end
  end
end
