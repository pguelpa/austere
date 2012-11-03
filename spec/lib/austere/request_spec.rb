require 'spec_helper'

describe Austere::Request do
  describe "::new" do
    it "should set the method" do
      request = Austere::Request.new(:get) {}
      request.method.should == :get
    end
  end

  describe "#body" do
    it "should create a body object" do
      request = Austere::Request.new(anything)

      block = Proc.new {}
      Austere::Body.should_receive(:new).with(&block).and_return(:body)
      request.body(&block)
      request.instance_variable_get("@body").should == :body
    end
  end

  describe "#response" do
    it "should create a response object" do
      request = Austere::Request.new(anything)

      block = Proc.new {}
      Austere::Response.should_receive(:new).with(200).and_return(:response)
      request.response(200, &block)
    end

    it "should add it to the list of responses" do
      request = Austere::Request.new(anything)

      block = Proc.new {}
      Austere::Response.should_receive(:new).and_return(:response)
      request.response(anything) {}
      request.responses.should == [:response]
    end
  end

  describe "#header" do
    it "should add a header to the list of headers" do
      Austere::Header.stub(:new).and_return(:header)
      request = Austere::Request.new(anything)

      request.header("Content-Type")
      request.headers.should == { "Content-Type" => :header }
    end

    it "should create a Validation with any given options" do
      Austere::Header.should_receive(:new).with(foo: "Bar")
      request = Austere::Request.new(anything)

      request.header("Content-Type", foo: "Bar")
    end
  end

  describe "#parameter" do

  end
end
