require 'templarbit/utils/rackhttp'

module Templarbit
  class Middleware::CookieTrap < Middleware
    def initialize(configuration)
      super

      @cookie = {
        name: "user-#{Digest::MD5.hexdigest('cheaphash' + @configuration.property_id)}",
        value: 'expires=-1&role=admin'
      }
    end

    def call(context)
      context.response.set_cookie(@cookie[:name], value: @cookie[:value], path: '/', expires: Time.now + 60 * 60 * 24 * 30)

      if context.request.cookies[@cookie[:name]] && context.request.cookies[@cookie[:name]] != @cookie[:value]
        srequest = Templarbit::Util::RackHttp.serialize_request(context.request)
        sresponse = Templarbit::Util::RackHttp.serialize_response(context.response)

        incident = Incident.new("reported", @cookie[:value], context.request.cookies[@cookie[:name]])
        context.add_incident(incident)
      end

      return context
    end

    # cookie trap incident
    class Incident < Models::Incident
      def initialize(status, expected, received)
        super()
        @type = "cookie-trap"
        @status = status
        @description = "Cookie was changed from $expected to $received"
        @data = {
          expected: expected,
          received: received
        }
      end
    end
  end
end
