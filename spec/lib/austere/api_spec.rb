require 'spec_helper'

describe Austere::Api do
  describe "::define" do
    it "should save the endpoint" do
      Austere::Endpoint.stub(:new).and_return(:endpointy)
      api = Austere::Api.define do |api|
        api.endpoint("/foo") {}
      end

      api.endpoints.should == [:endpointy]
    end

    it "should create a new Endpoint with the block" do
      block = Proc.new {}
      Austere::Endpoint.should_receive(:new).with("/foo", &block)

      api = Austere::Api.define do |api|
        api.endpoint "/foo", &block
      end
    end
  end

  describe "#match" do
    it "should return the first matching endpoint" do
      endpoint_1 = stub("Endpoint 1")
      endpoint_2 = stub("Endpoint 2")
      endpoint_3 = stub("Endpoint 3")

      endpoint_1.should_receive(:match).with(:put, "/foo").and_return(nil)
      endpoint_2.should_receive(:match).with(:put, "/foo").and_return(:request)
      endpoint_3.should_not_receive(:match)

      api = Austere::Api.new {}
      api.stub(:endpoints).and_return( [endpoint_1, endpoint_2] )

      api.match(:put, "/foo").should == :request
    end
  end
end
