require 'spec_helper'

describe Austere::Parameter do
  describe "::new" do
    it "should save the name" do
      parameter = Austere::Parameter.new("per_page", {})
      parameter.name.should == "per_page"
    end

    it "should save the description" do
      parameter = Austere::Parameter.new(anything, description: "Baz")
      parameter.description.should == "Baz"
    end

    it "should create a validation" do
      Austere::Validation.should_receive(:new).with(optional: true)
      Austere::Parameter.new(anything, optional: true)
    end
  end
end
