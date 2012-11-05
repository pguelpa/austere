module Austere
  class Response
    attr_accessor :codes, :headers

    def initialize(*codes, &block)
      @codes = codes
      @headers = {}
    end

    def body(&block)
      @body = Austere::Body.new(&block)
    end

    def header(name, options = {})
      @headers[name] = Austere::Header.new(name, options)
    end
  end
end
