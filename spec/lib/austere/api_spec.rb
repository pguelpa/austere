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
end
