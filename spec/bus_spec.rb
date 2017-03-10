require "spec_helper"

context "when there is an handler configured for a message" do

  class TestEvent

  end

  class TestEventHandler

    attr_reader :handled
    @handled

    def handle(message)
      @handled = true
    end
  end

  before do
    bus = Rbus::Bus.new
    @test_event_handler = TestEventHandler.new
    bus.add_handler(TestEvent, @test_event_handler)
  end

  it "should dispatch the message to the confugured handler" do
    expect(@test_event_handler.handled).to be_true
  end
end
