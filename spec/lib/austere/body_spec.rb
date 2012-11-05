require 'spec_helper'

describe Austere::Body do
  describe "#element" do
    it "should add a new element to the list of elements" do
      options = { baz: "Zap" }
      Austere::Element.
        should_receive(:new).
        with(:version, String, options).
        and_return(:element)

      body = Austere::Body.new do |b|
        b.element :version, String, options
      end

      body.elements.should == { version: :element }
    end

    it "should accept a type that is already an Element" do
      options = { baz: "Zap" }
      klass = Class.new(Austere::Element)
      klass.
        should_receive(:new).
        with(:klass, Austere::Element, options).
        and_return(:custom)

      body = Austere::Body.new do |b|
        b.element :klass, klass, options
      end

      body.elements.should == { klass: :custom }
    end
  end
end
