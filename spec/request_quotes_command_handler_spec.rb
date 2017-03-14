require "spec_helper"

context "when handling a request quotes command" do

  before do
    @bus = instance_double("Rbus::Bus")
    #allow(@bus).to receive(:publish)
    @command = {:policyId => 1}
    @handler = Handlers::RequestQuotesCommandHandler.new(@bus)

  end

  it 'should generate the quotes' do

  end

  it "should publish a quotes generated event" do
    #expect(@bus).to receive(:publish).with({:quotes => [1,2,3]})
    expect(@bus).to receive(:publish).with(kind_of(Handlers::QuotesGeneratedEvent))
    @handler.handle(@command)
  end

  class RequestQuotesCommand

  end
end
