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

    def post(&block)
      @requests << Austere::Request.new(:post, &block)
    end

    def put(&block)
      @requests << Austere::Request.new(:put, &block)
    end

    def delete(&block)
      @requests << Austere::Request.new(:delete, &block)
    end
  end
end
