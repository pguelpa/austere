module Austere
  class Body # TODO: Rename to Node
    attr_reader :elements

    def initialize(&block)
      @elements = {}
      block.call(self)
    end

    def element(name, type, options = {})
      if type <= Austere::Element
        @elements[name] = type.new(name, Austere::Element, options)
      else
        @elements[name] = Austere::Element.new(name, type, options)
      end
    end
  end
end
