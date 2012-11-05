module Austere
  class Element
    attr_reader :name, :type, :description, :validation

    def initialize(name, type, options = {})
      @name = name
      @type = type
      @description = options.delete(:description)
      @validation = Austere::Validation.new(options)
    end

    private

    def description=(value)
      @description = value
    end
  end
end
