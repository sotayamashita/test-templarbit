require 'spec_helper'
require 'templarbit/models/incident'

RSpec.describe Templarbit::Models::Incident do
  it { should respond_to(
    :data, 
    :description, 
    :sub_type, 
    :trace, 
    :type,
    :status
    ) }

  describe '#as_json' do
    subject(:basic_incident_as_json) { 
      basic_incident = Templarbit::Models::Incident.new
      basic_incident.as_json
    }

    it { should include(:data => nil ) }
    it { should include(:description => nil ) }
    it { should include(:sub_type => nil ) }
    it { should include(:trace => instance_of(Array)) }
    it { should include(:type => nil ) }
    it { should include(:status => nil ) }
  end
end
