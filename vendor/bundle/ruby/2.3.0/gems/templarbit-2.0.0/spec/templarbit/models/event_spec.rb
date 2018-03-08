require 'spec_helper'
require 'templarbit/models/event'

require 'rack'
require 'json'
require 'date'

RSpec.describe Templarbit::Models::Event do
  subject(:basic_event) { Templarbit::Models::Event.new }

  it { should respond_to(
    :data,
    :http,
    :incidents, 
    :platform, 
    :platform_version,
    :property_id, 
    :runtime_version, 
    :sdk, 
    :sdk_version, 
    :source, 
    :tags, 
    :timestamp,
    :transaction_id,
    :user
  ) }

  it { should_not respond_to(:timestamp=) }

  describe '#as_json' do
    subject(:basic_event_as_json) { 
      basic_event.as_json
    }

    it { should include(:data => nil ) }
    it { should include(:http => instance_of(Templarbit::Models::HTTP)) }
    it { should include(:incidents => instance_of(Array)) }
    it { should include(:platform => RUBY_ENGINE ) }
    it { should include(:platform_version => RUBY_VERSION ) }
    it { should include(:runtime_version => nil ) }
    it { should include(:sdk => 'templarbit-ruby' ) }
    it { should include(:sdk_version => Templarbit::VERSION ) }
    it { should include(:source => nil ) }
    it { should include(:tags => instance_of(Hash)) }
    it { should include(:timestamp => instance_of(DateTime)) }
    it { should include(:transaction_id => nil ) }
    it { should include(:user => instance_of(Templarbit::Models::User)) }
  end

  describe 'Event.new_from_context' do
    subject(:event_from_context) { Templarbit::Models::Event.new_from_context(Templarbit::Context.new) }

    it { should have_attributes(:data => nil ) }
    it { should have_attributes(:http => instance_of(Templarbit::Models::HTTP)) }
    it { should have_attributes(:incidents => instance_of(Array)) }
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
  end
end
