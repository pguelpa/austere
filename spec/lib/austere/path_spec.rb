require 'spec_helper'

describe Austere::Path do
  describe "#split" do
    it "splits the path into components" do
      path = Austere::Path.new("foo/bar")
      path.split.should == ["foo", "bar"]
    end

    it "should remove any format" do
      path = Austere::Path.new("foo/bar.json")
      path.split.should == ["foo", "bar"]
    end
  end

  describe "#parameters" do
    it "returns an array of parameter components" do
      path = Austere::Path.new("users/:user_id/comments/:id")
      path.parameters.should == ["user_id", "id"]
    end
  end

  describe "#format" do
    it "returns the format of the path" do
      path = Austere::Path.new("users.json")
      path.format.should == "json"
    end

    it "is nil if there is no format" do
      path = Austere::Path.new("users")
      path.format.should == nil
    end
  end

  describe "#==" do
    it "returns true if a path matches" do
      Austere::Path.new("a/b/c").should == "a/b/c"
    end

    it "returns true if a path with parameters matches" do
      Austere::Path.new("user/:id.json").should == "user/10.json"
    end

    it "returns false if the formats don't match" do
      Austere::Path.new("user.json").should_not == "user.xml"
    end

    it "returns false for paths of different sizes" do
      Austere::Path.new("users/10/comments").should_not == "users/10/comments/99"
    end
  end
end
