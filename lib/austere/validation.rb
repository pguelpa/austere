module Austere
  class Validation
    attr_reader :optional, :format, :validator, :message, :errors

    def initialize(options = {})
      @optional = options.delete(:optional) || false
      @format = options.delete(:format)
      @validator = options.delete(:validator)
      @message = options.delete(:message)
      @errors = []
    end

    def validate(value)
      if format && ((value =~ format) == nil)
        @errors << (@message || "doesn't match format #{format.source}")
      end

      if validator && !validator.call(value)
        @errors << (@message || "is not valid")
      end

      @errors.empty?
    end
  end
end
