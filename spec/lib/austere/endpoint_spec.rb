require 'spec_helper'

describe Austere::Endpoint do
  describe "::new" do
    it "should set the path" do
      endpoint = Austere::Endpoint.new("/foo") {}
      endpoint.path.should == "/foo"
    end
  end

  [:get, :post, :put, :delete].each do |method|
    describe "##{method}" do
      it "should create a #{method} request" do
        block = Proc.new {}
        Austere::Request.should_receive(:new).with(method, &block)

        Austere::Endpoint.new(anything) do |e|
          e.send(method, &block)
        end
      end

      it "should save the request" do
        block = Proc.new {}
        Austere::Request.stub(:new).and_return(:request)

        endpoint = Austere::Endpoint.new(anything) do |e|
          e.send(method, &block)
        end

        endpoint.requests.should == [:request]
      end
    end
  end
end
