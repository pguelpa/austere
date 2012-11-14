module Austere
  class Api
    attr_reader :endpoints
    attr_accessor :base

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
      endpoints.each do |e|
        request = e.match(method, path)
        return request if request
      end
      # Match a path against this API's endpoints
      # Return the endpoint that it matches, or nil
    end
  end
end
