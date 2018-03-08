module Templarbit
  class Middleware::ContentSecurityPolicy < Middleware
    def call(context)
      if configuration.csp_last_updated + configuration.csp_update_interval < Time.now
        csp = Templarbit.client.fetch(:csp)
        return if csp.nil?
        
        configuration.csp = csp[:csp]
        configuration.csp_report_only = csp[:csp_report_only]
        configuration.csp_last_updated = Time.now
      end

      if configuration.csp
        context.response.set_header('Content-Security-Policy', configuration.csp)
      end

      if configuration.csp_report_only
        context.response.set_header('Content-Security-Policy-Report-Only', configuration.csp_report_only)
      end

      return context
    end
  end
end
