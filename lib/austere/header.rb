module Austere
  class Header
    attr_reader :validation, :description

    def initialize(options = {})
      @description = options.delete(:description)
      @validation = Austere::Validation.new(options)
    end
  end
end
