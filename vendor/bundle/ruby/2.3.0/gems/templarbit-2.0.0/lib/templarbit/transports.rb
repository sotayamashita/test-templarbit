module Templarbit
  module Transports
    class Transport
      attr_accessor :configuration

      def initialize(configuration)
        @configuration = configuration
      end

      def send_event
        raise NotImplementedError, 'not implemented'
      end

      def fetch
        raise NotImplementedError, 'not implemented'
      end
    end
  end
end
