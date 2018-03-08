module Templarbit
  module Models
    class HTTP
      attr_accessor :request, 
                    :response

      def self.new_from_context(context)
        http = self.new
        http.request = Request.new_from_context(context)
        http.response = Response.new_from_context(context)
        return http
      end

      def initialize
        @request = Request.new
        @response = Response.new
      end

      def as_json(options={})
        { 
          request: @request,
          response: @response
        }
      end

      def to_json(*options)
          as_json(*options).to_json(*options)
      end
    end
  end
end
module Templarbit
  module Models
    class HTTP
      class Request
        attr_accessor :body, 
                      :headers, 
                      :method, 
                      :url

        def self.new_from_context(context)
          request = self.new
          
          return request if context.request.nil?

          serialized_request = Templarbit::Util::RackHttp.serialize_request(context.request)

          request.body = serialized_request[:body]
          request.headers = serialized_request[:headers]
          request.method = serialized_request[:method]
          request.url = serialized_request[:url]

          return request
        end

        def initialize
          @headers = []
        end

        def as_json(options={})
          { 
            body: @body,
            headers: @headers,
            method: @method,
            url: @url
          }
        end

        def to_json(*options)
            as_json(*options).to_json(*options)
        end
      end

      class Response
        attr_accessor :body,
                      :headers, 
                      :status

        def self.new_from_context(context)
          response = self.new

          return response if context.response.nil?

          serialized_response = Templarbit::Util::RackHttp.serialize_response(context.response)
          response.body = serialized_response[:body]
          response.headers = serialized_response[:headers]
          response.status = serialized_response[:status]

          return response
        end

        def initialize
          @headers = []
        end

        def as_json(options={})
          { 
            body: @body,
            headers: @headers,
            status: @status
          }
        end

        def to_json(*options)
            as_json(*options).to_json(*options)
        end
      end
    end
  end
end