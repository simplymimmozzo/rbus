require "spec_helper"

class TestEvent

end

class TestEventHandler

  attr_reader :handled
  @handled

  def handle(message)
    @handled = true
  end
end

context "when an event is published and there is an handler configured for it" do

  before do
    bus = Rbus::Bus.new
    @test_event_handler = TestEventHandler.new
    bus.add_handler(TestEvent, @test_event_handler)
    bus.publish TestEvent.new
  end

  it "should dispatch the message to the configured handler" do
    expect(@test_event_handler.handled).to be true
  end
end

context "when an event is published and there is no handler configured for it" do

  before do
    @bus = Rbus::Bus.new
    @test_event_handler = TestEventHandler.new
  end

  it "should not complain about it" do
    expect{@bus.publish TestEvent.new}.to_not raise_error
  end
end
