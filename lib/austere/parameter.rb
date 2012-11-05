module Austere
  class Parameter
    attr_reader :name, :validation, :description

    def initialize(name, options = {})
      @name = name
      @description = options.delete(:description)
      @validation = Austere::Validation.new(options)
    end
  end
end
