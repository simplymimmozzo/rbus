require "rbus/version"

module Rbus
  class Bus



    def initialize

    end

    def add_handler(message_type, handler)
      @handler = handler
    end

    def publish(message)
      @handler.handle message if @handler
    end
  end
end
