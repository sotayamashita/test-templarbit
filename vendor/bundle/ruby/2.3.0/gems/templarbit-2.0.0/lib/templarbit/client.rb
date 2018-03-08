module Templarbit
  class Client
    attr_accessor :configuration

    def initialize(configuration)
      @configuration = configuration
    end

    def send_event(event)
      configuration.logger.info "Sending event with incidents #{event.incidents.collect{|e|e.type}}"
      begin
        configuration.transport.send_event(
          event,
          configuration.property_id,
          configuration.secret_key
        )
      rescue StandardError => e
        configuration.logger.warn e
      end
    end

    def fetch(kind)
      configuration.transport.fetch(
        kind,
        configuration.property_id,
        configuration.secret_key
      )
    end
  end
end
