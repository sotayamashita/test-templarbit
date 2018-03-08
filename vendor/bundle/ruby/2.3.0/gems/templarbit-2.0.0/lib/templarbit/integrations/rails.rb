require 'templarbit/integrations/rack'

require 'rails'

module Templarbit
  class Rails < ::Rails::Railtie
    initializer 'templarbit.use_rack_middleware' do |app|
      app.config.middleware.use Templarbit::Rack
    end
  end
end
