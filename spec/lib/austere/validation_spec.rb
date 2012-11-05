require 'spec_helper'

describe Austere::Validation do
  describe "::new" do
    it "should set the format" do
      validation = Austere::Validation.new(format: /abcd/)
      validation.format.should == /abcd/
    end

    context "optional flag" do
      it "should be false by default" do
        validation = Austere::Validation.new
        validation.optional.should == false
      end

      it "should set the optional flag if given" do
        validation = Austere::Validation.new(optional: true)
        validation.optional.should == true
      end
    end

    it "should set the validator" do
      block = Proc.new {}
      validation = Austere::Validation.new(validator: block)
      validation.validator.should == block
    end

    it "should set the message" do
      validation = Austere::Validation.new(message: "Foo is bad")
      validation.message.should == "Foo is bad"
    end
  end

  describe "#validate" do
    it "should validate the format" do
      validation = Austere::Validation.new(format: /[0-9]+/)
      validation.validate("1234").should == true
      validation.validate("abcd").should == false
    end

    it "should validate with the validator" do
      validation = Austere::Validation.new(validator: lambda { |v| ["a", "b", "c"].include?(v) } )
      validation.validate("a").should == true
      validation.validate("z").should == false
    end

    it "should aggregate all validations" do
      validator = lambda { |v| ["a", "b", "c"].include?(v) }
      validation = Austere::Validation.new(format: /[0-9]+/, validator: validator)

      validation.validate("1234").should == false
      validation.validate("a").should == false
    end

    context "errors" do
      it "should set the errors for an invalid format" do
        validation = Austere::Validation.new(format: /[0-9]+/)
        validation.validate("aaa")
        validation.errors.should == ["doesn't match format [0-9]+"]
      end

      it "should use the customer message for an invalid format" do
        validation = Austere::Validation.new(format: /[0-9]+/, message: "It's bad")
        validation.validate("aaa")
        validation.errors.should == ["It's bad"]
      end

      it "should set the errors for an invalid validator" do
        validation = Austere::Validation.new(validator: Proc.new { false })
        validation.validate("aaa")
        validation.errors.should == ["is not valid"]
      end

      it "should use the customer message for an invalid format" do
        validation = Austere::Validation.new(validator: Proc.new { false }, message: "It's still bad")
        validation.validate("aaa")
        validation.errors.should == ["It's still bad"]
      end
    end
  end
end
