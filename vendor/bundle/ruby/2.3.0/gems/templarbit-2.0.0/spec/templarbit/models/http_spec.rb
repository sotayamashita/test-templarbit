require 'spec_helper'
require 'templarbit/models/http'

RSpec.describe Templarbit::Models::HTTP do
  it { should respond_to(
    :request, 
    :response
    ) }

  describe '#as_json' do
    subject(:basic_http_as_json) { 
      basic_http = Templarbit::Models::HTTP.new
      basic_http.as_json
    }

    it { should include(:request => instance_of(Templarbit::Models::HTTP::Request)) }
    it { should include(:response => instance_of(Templarbit::Models::HTTP::Response)) }
  end
end

RSpec.describe Templarbit::Models::HTTP::Request do
  it { should respond_to(
    :body, 
    :headers, 
    :method, 
    :url
    ) }

  describe '#as_json' do
    subject(:basic_request_as_json) { 
      basic_http = Templarbit::Models::HTTP::Request.new
      basic_http.as_json
    }

    it { should include(:body => nil ) }
    it { should include(:headers => instance_of(Array)) }
    it { should include(:method => nil ) }
    it { should include(:url => nil ) }
  end
end

RSpec.describe Templarbit::Models::HTTP::Response do
  it { should respond_to(
    :body,
    :headers, 
    :status
    ) }

  describe '#as_json' do
    subject(:basic_response_as_json) { 
      basic_http = Templarbit::Models::HTTP::Response.new
      basic_http.as_json
    }

    it { should include(:body => nil ) }
    it { should include(:headers => instance_of(Array)) }
    it { should include(:status => nil ) }
  end
end