require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

use Templarbit::Rack

Templarbit.configure do |config|
  config.property_id = "test"
  config.secret_key = "test"
end

get '/' do
  'Hello world'
end
