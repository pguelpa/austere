module Austere
  class Request
    attr_accessor :method, :path, :headers, :parameters, :responses

    def initialize(method, path)
      @responses = {}
      @headers = {}
      @parameters = {}
      @method = method
      @path = path

      yield(self)
    end

    def description(description)
      @description = description
    end

    def to_s
      @description || ""
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

    def match(method, path)

    end
  end
end
