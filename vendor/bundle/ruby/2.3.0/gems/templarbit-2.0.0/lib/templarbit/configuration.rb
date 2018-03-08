module Templarbit
  class Configuration
    attr_accessor :transport

    attr_accessor :logger

    attr_accessor :property_id

    attr_accessor :secret_key

    attr_accessor :csp, :csp_report_only, :csp_last_updated, :csp_update_interval

    attr_accessor :api_url, :logs_url

    def initialize
      self.transport = ::Templarbit::Transports::HTTP.new
      self.logger = ::Templarbit::Logger.new(STDOUT)
      self.csp_last_updated = Time.now
      self.csp_update_interval = 60 # sec
      self.api_url = 'https://api.templarbit.com'
      self.logs_url = 'https://log.templarbit.com'
    end
  end
end
