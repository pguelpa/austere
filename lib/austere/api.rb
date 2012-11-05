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
  end
end
