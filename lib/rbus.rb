require "rbus/version"

module Rbus
  class Bus

    def initialize
      @handlers = Hash.new
    end

    def add_handler(message_type, handler)
      raise BusConfigurationError, "Invalid nil handler instance" if ! handler
      @handlers[message_type] = [] unless @handlers[message_type]
      @handlers[message_type] << handler
    end

    def publish(message)
      return if !@handlers[message.class]
      @handlers[message.class].each do |handler|
        handler.handle message
      end
    end

    def send(message)
      raise BusConfigurationError, "No handler configured for command #{message.class.name}" if !@handlers[message.class]
      raise BusConfigurationError, "Too many handlers configured for command #{message.class.name}, only 1 is allowed" if @handlers[message.class].count != 1
      handler = @handlers[message.class].first
      handler.handle message
    end
  end

  class BusConfigurationError < StandardError
  end
end
