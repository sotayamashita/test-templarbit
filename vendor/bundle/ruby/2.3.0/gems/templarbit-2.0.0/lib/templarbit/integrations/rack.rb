require 'rack'
require 'digest'

module Templarbit
  class Rack
    def initialize(app)
      @app = app
    end

    def call(env)
      request = ::Rack::Request.new(env)
      status, headers, body = @app.call(env)
      response = ::Rack::Response.new(body, status, headers)

      Templarbit.use(Middleware::ContentSecurityPolicy)
      Templarbit.use(Middleware::CookieTrap)
      response = Templarbit.finalize(request, response)
      
      response.finish
    end
  end
end
