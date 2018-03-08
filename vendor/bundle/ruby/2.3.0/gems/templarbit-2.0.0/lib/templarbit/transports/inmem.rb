require 'templarbit/transports'

module Templarbit
  module Transports
    class Inmem < Transport
      attr_accessor :events

      def initialize(*)
        super
        @events = []
      end

      def send_event(event, property_id, secret_key)
        @events << [event, property_id, secret_key]
      end

      def fetch(kind, _property_id, _secret_key)
        if kind == :csp
          {
            csp: "default-src: 'none'",
            csp_report_only: "default-src: 'none'"
          }
        end
      end
    end
  end
end
