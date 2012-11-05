require 'spec_helper'

describe Austere::Header do
  describe "::new" do
    it "should save the name" do
      header = Austere::Header.new("Content-Type", {})
      header.name.should == "Content-Type"
    end

    it "should save the description" do
      header = Austere::Header.new(anything, description: "Foo")
      header.description.should == "Foo"
    end

    it "should create a validation" do
      Austere::Validation.should_receive(:new).with(optional: true)
      Austere::Header.new(anything, optional: true)
    end
  end
end
