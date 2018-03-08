require 'spec_helper'
require 'templarbit/integrations/rack'

RSpec.describe Templarbit::Rack do
  let(:env) { Rack::MockRequest.env_for('/') }
  let(:app) { ->(_env) { [200, { 'Content-Type' => 'text/plain' }, ['OK']] } }
  subject(:basic_racked_app) { 
    Templarbit.configuration.property_id = 'test'
    Templarbit::Rack.new(app)
  }

  it { should respond_to(:call) }

  describe '#call' do
    it 'executes' do
      status, headers, body = basic_racked_app.call(env)
      expect(status).to equal(200)
      expect(headers).to include('Content-Security-Policy', 'Content-Security-Policy-Report-Only', 'Set-Cookie')
      expect(body).to be_instance_of(Rack::BodyProxy)
    end
  end
end
