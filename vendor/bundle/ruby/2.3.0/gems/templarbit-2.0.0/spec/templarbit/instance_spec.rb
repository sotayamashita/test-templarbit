require 'spec_helper'
require 'templarbit/instance'
require 'templarbit/middleware'
require 'templarbit/context'

class UserMiddleware < Templarbit::Middleware
  def call(context)
    context.user.id = 123
    context.user.email_address = 'example@example.com'
    context.user.name = 'John.Q.Citizen'

    return context
  end
end

class ResponseMiddleware < Templarbit::Middleware
  def call(context)
    context.response.body = "a whole new body"
  end
end

class IncidentMiddleware < Templarbit::Middleware
  def call(context)
    incident = Templarbit::Models::Incident.new
    incident.sub_type = 'mock_sub_type'
    incident.type = 'mock_type'
    incident.description = 'mock incident'

    context.add_incident(incident)

    return context
  end
end

RSpec.describe Templarbit::Instance do
  let(:basic_context) { Templarbit::Context.new }
  subject(:basic_instance) { Templarbit::Instance.new(basic_context) }

  it { should respond_to(:context) }
  it { should respond_to(:logger) }
  it { should respond_to(:client) }
  it { should respond_to(:configure) }
  it { should respond_to(:middleware) }
  it { should respond_to(:use) }
  it { should respond_to(:finalize) }
  it { should respond_to(:current_transaction_id) }
  it { should respond_to(:current_user) }

  describe '#current_user' do
    subject(:basic_instance) {
      basic_instance = Templarbit::Instance.new(basic_context)
      basic_instance.current_user(123, 'example@example.com', 'John.Q.Citizen')
      return basic_instance
    }
    it { expect(subject.context.user.id).to eq(123) }
    it { expect(subject.context.user.email_address).to eq('example@example.com') }
    it { expect(subject.context.user.name).to eq('John.Q.Citizen') }
  end

  describe '#current_transaction_id' do
    subject(:basic_instance) {
      basic_instance = Templarbit::Instance.new(basic_context)
      basic_instance.current_transaction_id(123)
      return basic_instance
    }
    it { expect(subject.context.transaction_id).to eq(123) }
  end

  describe '#use' do
    it 'stacks middleware instances' do
      expect(basic_instance.middleware.length).to equal(0)
      basic_instance.use(UserMiddleware)
      expect(basic_instance.middleware.length).to equal(1)
      expect(basic_instance.middleware.last).to be_instance_of(UserMiddleware)
      basic_instance.use(ResponseMiddleware)
      expect(basic_instance.middleware.length).to equal(2)
      expect(basic_instance.middleware.last).to be_instance_of(ResponseMiddleware)
      basic_instance.use(UserMiddleware)
      expect(basic_instance.middleware.length).to equal(2)
      expect(basic_instance.middleware.last).to be_instance_of(ResponseMiddleware)
    end
  end

  describe '#finalize' do
    let(:rack_env) { ::Rack::MockRequest.env_for('http://example.com/mock') }
    let(:rack_request) { 
      rack_request = ::Rack::Request.new(rack_env) 
      rack_request.set_header('REMOTE_ADDR', '127.0.0.1')
      return rack_request
    }
    let(:rack_response) { ::Rack::Response.new(::Rack::BodyProxy.new('some body; any body'),200,{}) }

    it 'uses middleware' do
      basic_instance.use(UserMiddleware)
      basic_instance.use(ResponseMiddleware)
      basic_instance.use(UserMiddleware)
      basic_instance.use(IncidentMiddleware)
      basic_instance.use(IncidentMiddleware)

      basic_instance.use(lambda { |context| 
        expect(context.request).to eq(rack_request)
        expect(context.response.body).to eq('a whole new body')
        expect(context.user.id).to eq(123)
        expect(context.user.email_address).to eq('example@example.com')
        expect(context.user.name).to eq('John.Q.Citizen')

        expect(basic_instance.context.incidents.length).to eq(1)
      })

      basic_instance.finalize(rack_request, rack_response)
    end

    it 'clears context' do
      basic_instance.use(IncidentMiddleware)

      basic_instance.use(lambda { |context| expect(context.incidents.length).to eq(1) })

      basic_instance.finalize(rack_request, rack_response)
      basic_instance.finalize(rack_request, rack_response)
    end

    it 'clears thread specific context' do
      instance = Templarbit::Instance.new()

      instance.use(IncidentMiddleware)
      
      instance.use(lambda { |context| expect(context.incidents.length).to eq(1) })

      instance.finalize(rack_request, rack_response)
      instance.finalize(rack_request, rack_response)
    end
  end
end
