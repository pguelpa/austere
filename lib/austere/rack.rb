module Austere
  class Lint
    def initialize(app)
      @app = app
    end

    def call(env)
      # Check request
      # Alter if invalid

      status, headers, response = @app.call(env)
      # Check response
      # Alter if invalid

      [status, headers, response.body]
    end
  end
end
