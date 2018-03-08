require 'spec_helper'
require 'templarbit/context'
require 'templarbit/models/event'

require 'rack'

RSpec.describe Templarbit::Context do
  subject(:basic_context) { Templarbit::Context.new }
  let(:basic_incident) { 
    basic_incident = Templarbit::Models::Incident.new
    basic_incident.sub_type = 'mock_sub_type'
    basic_incident.type = 'mock_type'
    basic_incident.description = 'mock incident'
    return basic_incident
  }
  
  it { expect(described_class).to respond_to(:current) }
  it { expect(described_class).to respond_to(:clear!) }

  it { should respond_to(:transaction_id) }

  it { should respond_to(:request) }
  it { should respond_to(:response) }
  it { should respond_to(:user) }
  it { should respond_to(:incidents) }
  it { should_not respond_to(:incidents=) }

  it { should respond_to(:add_incident) }
  it { should respond_to(:incidents?) }

  it { should respond_to(:event) }

  describe '#incidents' do
    it 'is publicly immutable' do
      expect { basic_context.incidents.push("something") }.to raise_error(RuntimeError)
    end
  end

  describe '#add_incident' do
    it 'pushes an incident' do
      expect(basic_context.incidents.count).to equal(0)
      basic_context.add_incident(basic_incident)
      expect(basic_context.incidents.count).to equal(1)
    end
  end

  describe '#incidents?' do
    it 'a boolean alias for #length' do
      expect(basic_context.incidents?).to equal(false)

      basic_context.add_incident(basic_incident)
      expect(basic_context.incidents?).to equal(true)

      basic_context.add_incident(basic_incident)
      expect(basic_context.incidents?).to equal(true)
    end
  end

  describe '#event' do
    context 'no incidents' do
      it { should have_attributes(:event => nil) }
    end

    context 'some incidents' do
      let(:rack_env) { ::Rack::MockRequest.env_for('http://example.com/mock') }
      let(:rack_request) { 
        rack_request = ::Rack::Request.new(rack_env) 
        rack_request.set_header('REMOTE_ADDR', '127.0.0.1')
        return rack_request
      }
      let(:rack_response) { ::Rack::Response.new(::Rack::BodyProxy.new('some body; any body'),200,{}) }
      let(:basic_user) {
        basic_user = Templarbit::Models::User.new
        basic_user.id = 123
        basic_user.email_address = 'example@example.com'
        basic_user.name = 'John.Q.Citizen'
        return basic_user
      }
      let(:racked_context) {
          racked_context = Templarbit::Context.new
          racked_context.request = rack_request
          racked_context.response = rack_response
          racked_context.user = basic_user
          racked_context.add_incident(basic_incident)
          return racked_context
      }

      subject(:racked_context_event) { return racked_context.event }

      it { should have_attributes(:data => nil ) }

      it { should have_attributes(:http => instance_of(Templarbit::Models::HTTP)) }
      describe '.http' do
        subject(:racked_context_event_http) { racked_context_event.http }
        it { should have_attributes(:request => instance_of(Templarbit::Models::HTTP::Request)) }
        describe '.request' do
          subject(:racked_context_event_http_request) {
            racked_context_event_http.request
          }
          it { should have_attributes(:body => nil) }
          it { should have_attributes(:headers => [{ 'Content-Length' => '0' }]) }
          it { should have_attributes(:method => 'GET') }
          it { should have_attributes(:url => 'http://example.com/mock') }
        end
        it { should have_attributes(:response => instance_of(Templarbit::Models::HTTP::Response)) }
        describe '.response' do
          subject(:racked_context_event_http_response) { racked_context_event_http.response }
          it { should have_attributes(:body => nil) }
          it { should have_attributes(:headers => [{ 'Content-Length' => '19' }]) }
          it { should have_attributes(:status => 200) }
        end
      end

      it { should have_attributes(:incidents => instance_of(Array)) }
      describe '.incidents' do 
        subject(:racked_context_event_incidents) { racked_context_event.incidents }
        it { should have_attributes(:length => 1) }
        it { should have_attributes(:first => instance_of(Templarbit::Models::Incident)) }
        describe 'incident' do
          subject(:racked_context_event_incident) { racked_context_event_incidents.first }
          it { should have_attributes(:sub_type => 'mock_sub_type' ) }
          it { should have_attributes(:type => 'mock_type' ) }
          it { should have_attributes(:description => 'mock incident' ) }
        end
      end

      it { should have_attributes(:platform => RUBY_ENGINE ) }
      it { should have_attributes(:platform_version => RUBY_VERSION ) }
      it { should have_attributes(:runtime_version => nil ) }
      it { should have_attributes(:sdk => 'templarbit-ruby' ) }
      it { should have_attributes(:sdk_version => Templarbit::VERSION ) }
      it { should have_attributes(:source => nil ) }
      it { should have_attributes(:tags => instance_of(Hash)) }
      it { should have_attributes(:timestamp => instance_of(DateTime)) }
      it { should have_attributes(:transaction_id => nil ) }

      it { should have_attributes(:user => instance_of(Templarbit::Models::User)) }
      describe '.user' do
          subject(:racked_context_event_user) { racked_context_event.user }
          it { should have_attributes(:email_address => 'example@example.com' ) }
          it { should have_attributes(:id => 123 ) }
          it { should have_attributes(:ip_address => '127.0.0.1' ) }
          it { should have_attributes(:name => 'John.Q.Citizen' ) }
      end
    end
  end
end
