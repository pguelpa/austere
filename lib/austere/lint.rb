module Austere
  class Lint
    def initialize(app, api)
      @app = app
      @api = api
    end

    def call(env)
      # REQUEST_METHOD
      # PATH_INFO
      #
      # Check request
      # Alter if invalid

      status, headers, response = @app.call(env)
      # Check response
      # Alter if invalid

      [status, headers, response.body]
    end
  end
end
