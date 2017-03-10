require "spec_helper"

class TestEvent

end


class AnotherTestEvent

end

class TestEventHandler

  attr_reader :received_message
  @received_message

  def handle(message)
    @received_message = true
  end
end

class AnotherTestEventHandler

  attr_reader :received_message
  @received_message

  def handle(message)
    received_message = true
  end
end

context "when an event is published and there is an handler configured for it" do

  before do
    bus = Rbus::Bus.new
    @test_event_handler = TestEventHandler.new
    @another_test_event_handler = AnotherTestEventHandler.new
    bus.add_handler(TestEvent, @test_event_handler)
    bus.add_handler(AnotherTestEvent, @another_test_event_handler)
    bus.publish TestEvent.new
  end

  it "should dispatch the message to the configured handler" do
    expect(@test_event_handler.received_message).to be true
  end

  it "should not dispatch the message to a non relevant handler" do
    expect(@another_test_event_handler.received_message).to be false
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
