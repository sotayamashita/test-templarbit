module Templarbit
  module Util
    module RackHttp
      def self.serialize_request(request)
        h = []
        exclude = %w[HTTP_VERSION HTTP_HOST]
        include = %w[CONTENT_TYPE CONTENT_LENGTH]

        request.each_header do |n, v|
          n = n.to_s
          v = v.to_s
          if (n.start_with?('HTTP_') || include.include?(n)) && !exclude.include?(n)
            h << { n.gsub('HTTP_', '').split('_').map(&:capitalize).join('-').to_s => v.to_s }
          end
        end

        if request.body
          body = request.body.read(4096)
          request.body.rewind
        end

        {
          method: request.get_header('REQUEST_METHOD'),
          url: request.url,
          proto: request.get_header('HTTP_VERSION'),
          headers: h,
          body: body || nil,
          ip_address: request.ip
        }
      end

      def self.serialize_response(response)
        h = []
        response.header.each do |n, v|
          h << {n => v}
        end

        {
          headers: h,
          body: nil,
          status: response.status.to_i
        }
      end
    end
  end
end
