require 'templarbit/transports'

require 'net/http'
require 'uri'
require 'json'
require 'openssl'

module Templarbit
  module Transports
    class HTTP < Transport
      def initialize; end

      def send_event(event, property_id, secret_key)
        uri = URI.parse(Templarbit.configuration.logs_url + '/events')
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        # http.cert = OpenSSL::X509::Certificate.new(pem)
        # http.key = OpenSSL::PKey::RSA.new(pem)
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER

        request = Net::HTTP::Post.new(uri.request_uri)
        request['User-Agent'] = "templarbit-ruby/#{Templarbit::VERSION}"
        request['Authorization'] = "bearer #{secret_key}"
        request.body = JSON.generate(event)
        response = http.request(request)

        if response.code.to_i != 201
          raise RuntimeError, "Failed to send event, code #{response.code}, #{response.body}"
        else
          return response.code
        end
      end

      def fetch(kind, property_id, secret_key)
        if kind == :csp
          uri = URI.parse(Templarbit.configuration.api_url + '/v1/csp')
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = true
          # http.cert = OpenSSL::X509::Certificate.new(pem)
          # http.key = OpenSSL::PKey::RSA.new(pem)
          http.verify_mode = OpenSSL::SSL::VERIFY_PEER

          request = Net::HTTP::Post.new(uri.request_uri)
          request.set_form_data(
            'property_id' => property_id,
            'token' => secret_key
          )
          response = http.request(request)

          if response.code.to_i == 200
            j = JSON.parse(response.body)
            return {
              csp: j['csp'],
              csp_report_only: j['csp_report_only']
            }
          end
        end
      end
    end
  end
end
