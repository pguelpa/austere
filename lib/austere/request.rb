module Austere
  class Request
    attr_accessor :method, :headers, :responses

    def initialize(method, &block)
      @responses = []
      @headers = {}
      @method = method
    end

    def body(&block)
      @body = Austere::Body.new(&block)
    end

    def response(code, &block)
      @responses << Austere::Response.new(code, &block)
    end

    def header(field, options = {})
      @headers[field] = Austere::Header.new(options)
    end

    def parameter(name, options = {})

    end
  end
end
