module Handlers
  class RequestQuotesCommandHandler

    def initialize(bus)
      @bus = bus
    end

    def handle(command)
      #do something with the command, interact with the domain object(s)
      #generate quotes and persist them
      #@bus.publish({:quotes => [1,2,3]})
      @bus.publish(QuotesGeneratedEvent.new)
    end
  end

  class QuotesGeneratedEvent

  end
end
