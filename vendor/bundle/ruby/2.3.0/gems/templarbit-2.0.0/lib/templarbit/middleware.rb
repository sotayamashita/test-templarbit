module Templarbit
  class Middleware
    attr_reader :configuration

    def initialize(configuration = {})
      @configuration = configuration || Templarbit.configuration
    end

    def call(context = {})
      raise NotImplementedError
    end
  end
end