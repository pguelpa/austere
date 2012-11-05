require 'spec_helper'

describe Austere::Response do
  describe "::new" do
    it "should set the response codes" do
      response = Austere::Response.new(200)
      response.codes.should == [200]
    end
  end

  describe "#body" do
    it "should create a body object" do
      response = Austere::Response.new(anything)

      block = Proc.new {}
      Austere::Body.should_receive(:new).with(&block).and_return(:body)
      response.body(&block)
      response.instance_variable_get("@body").should == :body
    end
  end

  describe "#header" do
    it "should add a new header to the list of headers" do
      options = {foo: "bar"}
      Austere::Header.should_receive(:new).
        with("Content-Type", options).
        and_return(:header)

      response = Austere::Response.new(anything)
      response.header("Content-Type", options)
      response.headers.should == { "Content-Type" => :header }
    end
  end
end
