require 'spec_helper'

describe Austere::Endpoint do
  describe "::new" do
    it "should set the path" do
      endpoint = Austere::Endpoint.new("/foo") {}
      endpoint.path.should == "/foo"
    end
  end

  describe "#get" do
    it "should create a get request" do
      block = Proc.new {}
      Austere::Request.should_receive(:new).with(:get, &block)

      Austere::Endpoint.new(anything) do |e|
        e.get(&block)
      end
    end

    it "should save the request" do
      block = Proc.new {}
      Austere::Request.stub(:new).and_return(:request)

      endpoint = Austere::Endpoint.new(anything) do |e|
        e.get(&block)
      end

      endpoint.requests.should == [:request]
    end
  end
end
