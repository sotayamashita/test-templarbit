require 'spec_helper'
require 'templarbit/middleware/cookietrap'
require 'templarbit/context'

require 'rack'
require 'securerandom'

RSpec.describe Templarbit::Middleware::CookieTrap do
  subject(:cookie_trap) { 
    configuration = Templarbit::Configuration.new
    configuration.property_id = SecureRandom.uuid
    Templarbit::Middleware::CookieTrap.new(configuration)
  }
  let(:racked_context) { 
    racked_context = Templarbit::Context.new
    racked_context.response = ::Rack::Response.new(::Rack::BodyProxy.new(""),200,[])
    return racked_context
  }
  let(:rack_env) { ::Rack::MockRequest.env_for('/') }

  describe '#use' do
    it 'traps a baddie' do
      #setup environment
      cookie = cookie_trap.instance_variable_get(:@cookie)
      rack_env["HTTP_COOKIE"] = "#{cookie[:name]}=#{cookie[:value]}"
      racked_context.request = Rack::Request.new(rack_env)

      #fake hacker
      tampered_cookie = { name: cookie[:name], value: 'expires=-1&role=none' }
      cookie_trap.instance_variable_set(:@cookie, tampered_cookie)

      #test
      expect(racked_context.incidents.length).to equal(0)
      trapped_context = cookie_trap.call(racked_context)
      expect(trapped_context.incidents.length).to equal(1)
      expect(trapped_context.incidents.last).to be_instance_of(Templarbit::Middleware::CookieTrap::Incident)
    end
  end
end

RSpec.describe Templarbit::Middleware::CookieTrap::Incident do
  subject(:cookie_incident) { Templarbit::Middleware::CookieTrap::Incident.new('reported', 'expected','received') }

  it { should have_attributes(:type => 'cookie-trap') }
  it { should have_attributes(:status => 'reported') }
  it { should have_attributes(:data => { expected: 'expected', received: 'received' } ) }
end
