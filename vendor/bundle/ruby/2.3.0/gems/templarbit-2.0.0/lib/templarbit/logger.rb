require 'logger'

module Templarbit
  class Logger < ::Logger
    def initialize(*)
      super
      @level = ::Logger::INFO
      original_formatter = ::Logger::Formatter.new
      @default_formatter = proc do |severity, datetime, _progname, msg|
        msg = "[Templarbit] #{msg}"
        original_formatter.call(severity, datetime, 'templarbit', msg)
      end
    end
  end
end
