require 'spec_helper'

describe Austere::Request do
  describe "::new" do
    it "should set the method" do
      request = Austere::Request.new(:get, anything) {}
      request.method.should == :get
    end

    it "should set the path" do
      request = Austere::Request.new(anything, "/foo") {}
      request.path.should == "/foo"
    end
  end

  describe "#body" do
    it "should create a body object" do
      request = Austere::Request.new(anything, anything) {}

      block = Proc.new {}
      Austere::Body.should_receive(:new).with(&block).and_return(:body)
      request.body(&block)
      request.instance_variable_get("@body").should == :body
    end
  end

  describe "#response" do
    it "should add a new response to the list of responses" do
      block = Proc.new {}
      Austere::Response.should_receive(:new).with(201, &block).and_return(:response)

      request = Austere::Request.new(anything, anything) {}
      request.response(201) {}
      request.responses.should == { 201 => :response }
    end
  end

  describe "#header" do
    it "should add a new header to the list of headers" do
      options = {foo: "bar"}
      Austere::Header.should_receive(:new).
        with("Content-Type", options).
        and_return(:header)

      request = Austere::Request.new(anything, anything) {}
      request.header("Content-Type", options)
      request.headers.should == { "Content-Type" => :header }
    end
  end

  describe "#parameter" do
    it "should add a new parameter to the list of parameters" do
      options = { bar: "Baz" }
      Austere::Parameter.should_receive(:new).
        with("per_page", options).
        and_return(:parameter)

      request = Austere::Request.new(anything, anything) {}
      request.parameter("per_page", options)
      request.parameters.should == { "per_page" => :parameter }
    end
  end
end
