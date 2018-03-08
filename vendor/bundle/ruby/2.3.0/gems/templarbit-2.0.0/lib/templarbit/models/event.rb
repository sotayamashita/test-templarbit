require 'templarbit/models/incident'
require 'templarbit/models/http'
require 'templarbit/models/user'

require 'date'

module Templarbit
  module Models
    class Event
      attr_reader :timestamp

      attr_accessor :data,
                    :http,
                    :incidents, 
                    :platform, 
                    :platform_version, 
                    :property_id, 
                    :runtime_version, 
                    :sdk, 
                    :sdk_version, 
                    :source, 
                    :tags, 
                    :transaction_id,
                    :user

      def self.new_from_context(context)
        event = self.new
        event.http = Templarbit::Models::HTTP.new_from_context(context)
        event.incidents = context.incidents
        event.user = Templarbit::Models::User.new_from_context(context)
        return event
      end

      def initialize
        @http = Templarbit::Models::HTTP.new
        @incidents = []
        @tags = {}
        @timestamp = DateTime.now
        @property_id = Templarbit.configuration.property_id
        @sdk = 'templarbit-ruby'.freeze
        @sdk_version = Templarbit::VERSION
        @platform = RUBY_ENGINE
        @platform_version = RUBY_VERSION
        @user = Templarbit.context.user || Templarbit::Models::User.new
      end

      def as_json(options={})
        { 
          data: @data,
          http: @http,
          incidents: @incidents,
          property_id: @property_id,
          platform: @platform,
          platform_version: @platform_version,
          runtime_version: @runtime_version,
          source: @source,
          sdk: @sdk,
          sdk_version: @sdk_version,
          tags: @tags,
          timestamp: @timestamp,
          transaction_id: @transaction_id,
          user: @user
        }
      end

      def to_json(*options)
          as_json(*options).to_json(*options)
      end
    end
  end
end
