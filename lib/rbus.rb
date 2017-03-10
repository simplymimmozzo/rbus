require "rbus/version"

module Rbus
  class Bus

    @handlers

    def initialize
      @handlers = Hash.new
    end

    def add_handler(message_type, handler)
      raise BusConfigurationError, "Invalid nil handler instance" if ! handler
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

    def send(message)
      raise BusConfigurationError, "No handler configured for command #{message.class.name}" if !@handlers[message.class.name]
      raise BusConfigurationError, "Too many handlers configured for command #{message.class.name}, only 1 is allowed" if @handlers[message.class.name].count != 1
      handler = @handlers[message.class.name].first
      handler.handle message
    end
  end

  class BusConfigurationError < StandardError
  end
end
