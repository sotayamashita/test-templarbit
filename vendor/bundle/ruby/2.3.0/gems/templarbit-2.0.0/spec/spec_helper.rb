require 'templarbit/base'
require 'templarbit/transports/inmem'

Templarbit.configure do |config|
  config.logger = Logger.new(nil)
  config.transport = ::Templarbit::Transports::Inmem.new({})
end

RSpec.configure do |config|
  config.mock_with(:rspec) { |mocks| mocks.verify_partial_doubles = true }
  config.raise_errors_for_deprecations!
  config.disable_monkey_patching!
  Kernel.srand config.seed
end
