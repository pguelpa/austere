module Austere
  class Endpoint
    attr_accessor :path, :description
    attr_reader :requests

    def initialize(path, &block)
      @path = path
      @requests = []

      block.call(self)
    end

    def get(&block)
      @requests << Austere::Request.new(:get, &block)
    end
  end
end
