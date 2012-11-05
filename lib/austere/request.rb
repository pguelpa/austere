module Austere
  class Request
    attr_accessor :method, :headers, :parameters, :responses

    def initialize(method, &block)
      @responses = {}
      @headers = {}
      @parameters = {}
      @method = method
    end

    def body(&block)
      @body = Austere::Body.new(&block)
    end

    def response(code, &block)
      @responses[code] = Austere::Response.new(code, &block)
    end

    def header(name, options = {})
      @headers[name] = Austere::Header.new(name, options)
    end

    def parameter(name, options = {})
      @parameters[name] = Austere::Parameter.new(name, options)
    end
  end
end
