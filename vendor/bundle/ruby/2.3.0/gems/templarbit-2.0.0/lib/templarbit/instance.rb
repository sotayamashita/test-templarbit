module Templarbit
  class Instance
    attr_reader :context,
                :logger,
                :middleware

    attr_writer :client

    attr_accessor :client, :configuration

    def initialize(context = nil, config = nil)
      @context = context || Context.current
      self.configuration = config || Configuration.new
    end

    def client
      @client ||= Client.new(configuration)
    end

    def context
      @context ||= Context.current
    end

    def logger
      configuration.logger
    end

    def middleware
      @middleware ||= []

      return @middleware.clone.freeze
    end

    def configure
      yield(configuration) if block_given?
      self.client = Client.new(configuration)

      # fetch latest csp
      csp = client.fetch(:csp)
      if csp
        configuration.csp = csp[:csp]
        configuration.csp_report_only = csp[:csp_report_only]
        configuration.csp_last_updated = Time.now
      end
    end

    def use(private_middleware)
      @middleware ||= []

      if private_middleware.is_a? Proc
        unless @middleware.include? private_middleware
          @middleware.push(private_middleware)
        end
      else
        unless @middleware.index{ |middleware| middleware.is_a? private_middleware }
          @middleware.push(private_middleware.new(self.configuration))
        end
      end
    end

    def finalize(request = {}, response = {})
      context.request = request
      context.response = response

      self.middleware.each { | middleware |
        _context = middleware.call(context)
        context = _context
      }

      if context.incidents?
        event = context.event
        event.property_id = configuration.property_id
        client.send_event(event)
      end

      response = context.response

      reset!

      return response
    end

    def current_transaction_id(id = '')
      context.transaction_id = id
    end

    def current_user(id = '', email_address = '', name = '')
      context.user.id = id
      context.user.email_address = email_address
      context.user.name = name
    end

    private

    def reset!
      Context.clear!
      @context = nil
    end

  end
end
