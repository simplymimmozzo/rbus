require "spec_helper"

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


context "when an event is published and there is more than one handler configured for it" do

  before do
    bus = Rbus::Bus.new
    @test_event_handler = TestEventHandler.new
    @another_test_event_handler = AnotherTestEventHandler.new
    bus.add_handler(TestEvent, @test_event_handler)
    bus.add_handler(TestEvent, @another_test_event_handler)
    bus.publish TestEvent.new
  end

  it "should dispatch the message to all configured handlers" do
    expect(@test_event_handler.received_message).to be true
    expect(@another_test_event_handler.received_message).to be true
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

context "when a command is sent and there is an handler configured for it" do

  before do
    bus = Rbus::Bus.new
    @test_command_handler = TestEventHandler.new
    bus.add_handler(TestEvent, @test_command_handler)
    bus.send TestEvent.new
  end

  it "should dispatch the message to the configured handler" do
    expect(@test_command_handler.received_message).to be true
  end

end


context "when a command is sent and there is no handler configured for it" do
  before do
    @bus = Rbus::Bus.new
  end

  it "should raise a BusConfiguration error" do
    expect {@bus.send TestEvent.new}.to raise_error(Rbus::BusConfigurationError)
  end

end

context "when a command is sent and there more than one handler configured for it" do
  before do
    @bus = Rbus::Bus.new
    @test_event_handler = TestEventHandler.new
    @another_test_event_handler = AnotherTestEventHandler.new
    @bus.add_handler(TestEvent, @test_event_handler)
    @bus.add_handler(TestEvent, @another_test_event_handler)
  end

  it "should raise a BusConfiguration error" do
    expect {@bus.send TestEvent.new}.to raise_error(Rbus::BusConfigurationError)
  end

end

class TestEvent

end


class AnotherTestEvent

end

class TestEventHandler

  attr_reader :received_message

  def initialize
    @received_message = false
  end

  def handle(message)
    @received_message = true
  end
end

class AnotherTestEventHandler

  attr_reader :received_message

  def initialize
    @received_message = false
  end

  def handle(message)
    @received_message = true
  end
end