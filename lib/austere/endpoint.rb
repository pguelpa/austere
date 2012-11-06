module Austere
  class Endpoint
    attr_accessor :path, :description
    attr_reader :requests

    def initialize(path, &block)
      @path = path
      @requests = []

      block.call(self)
    end

    def get(path, &block)
      @requests << Austere::Request.new(:get, path, &block)
    end

    def post(path, &block)
      @requests << Austere::Request.new(:post, path, &block)
    end

    def put(path, &block)
      @requests << Austere::Request.new(:put, path, &block)
    end

    def delete(path, &block)
      @requests << Austere::Request.new(:delete, path, &block)
    end
  end
end
