require 'spec_helper'

describe Austere::Element do
  describe "::new" do
    it "should set the name" do
      element = Austere::Element.new(:foo, anything)
      element.name.should == :foo
    end

    it "should set the type" do
      element = Austere::Element.new(anything, String)
      element.type.should == String
    end

    it "should set the description" do
      element = Austere::Element.new(anything, anything, description: "Bat")
      element.description.should == "Bat"
    end

    it "should create a Validation" do
      options = { foo: "Barts" }
      Austere::Validation.should_receive(:new).with(options).and_return(:validation)
      element = Austere::Element.new(anything, anything, options)

      element.validation.should == :validation
    end
  end
end
