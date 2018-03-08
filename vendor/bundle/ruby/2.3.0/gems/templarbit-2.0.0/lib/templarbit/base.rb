require 'templarbit/version'
require 'templarbit/context'
require 'templarbit/models'
require 'templarbit/logger'
require 'templarbit/client'
require 'templarbit/configuration'
require 'templarbit/transports'
require 'templarbit/transports/http'
require 'templarbit/utils/kernel'
require 'templarbit/utils/rackhttp'
require 'templarbit/instance'
require 'templarbit/middleware'
require 'templarbit/middleware/contentsecuritypolicy'
require 'templarbit/middleware/cookietrap'

require 'forwardable'

module Templarbit
  class << self
    extend Forwardable

    def instance
      @instance ||= Templarbit::Instance.new
    end

    def_delegators  :instance,
                    :client, :client=,
                    :configure, :configuration, :configuration=,
                    :context,
                    :logger,
                    :middleware,
                    :current_transaction_id, :current_user,
                    :use, :finalize

    def detect_integrations!
      loaded = Gem.loaded_specs
      try_in_order = %w[rails rack]
      try_in_order.each do |t|
        require "templarbit/integrations/#{t}" if loaded.include?(t)
      end
    end
  end
end
