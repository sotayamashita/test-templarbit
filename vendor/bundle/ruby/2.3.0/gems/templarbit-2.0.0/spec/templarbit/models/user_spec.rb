require 'spec_helper'
require 'templarbit/models/user'

RSpec.describe Templarbit::Models::User do
  it { should respond_to(
    :email_address, 
    :id, 
    :ip_address, 
    :name
    ) }

  describe '#as_json' do
    subject(:basic_user_as_json) { 
      basic_user = Templarbit::Models::User.new
      basic_user.as_json
    }

    it { should include(:email => nil ) }
    it { should include(:id => nil ) }
    it { should include(:ip => nil ) }
    it { should include(:name => nil ) }
  end
end