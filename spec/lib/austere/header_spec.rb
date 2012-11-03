require 'spec_helper'

describe Austere::Header do
  describe "::new" do
    it "should save the description" do
      header = Austere::Header.new(description: "Foo")
      header.description.should == "Foo"
    end

    it "should create a validation" do
      Austere::Validation.should_receive(:new).with(optional: true)
      Austere::Header.new(optional: true)
    end
  end
end
