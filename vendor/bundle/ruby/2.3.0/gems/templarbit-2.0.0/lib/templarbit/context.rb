require 'templarbit/utils/rackhttp'

require 'securerandom'
require 'json'

module Templarbit
  class Context
    def self.current
      Thread.current[:templarbit_context] ||= new
    end

    def self.clear!
      Thread.current[:templarbit_context] = nil
    end

    attr_accessor :request, :response, :transaction_id, :user

    def initialize
      @incidents = []
      @user = Models::User.new
    end

    def incidents
      @incidents.clone.freeze
    end

    def add_incident(incident)
      @incidents.push(incident)
    end

    def incidents?
      @incidents.length > 0
    end

    def event
      return Models::Event.new_from_context(self) if incidents?
    end
  end
end
