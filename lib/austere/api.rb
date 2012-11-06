module Austere
  class Api
    attr_reader :endpoints

    def self.define(&block)
      new(&block)
    end

    def initialize(&block)
      @endpoints = []
      block.call(self)
    end

    def endpoint(url, &block)
      @endpoints << Austere::Endpoint.new(url, &block)
    end

    def match(method, path)
      # Match a path against this API's endpoints
      # Return the endpoint that it matches, or nil
    end
  end
end
