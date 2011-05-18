require 'spec_helper'

describe CrowdRest::User do
  before do
    login = CrowdRest::Session.create("crowduser", "crowdpass")
    @user = CrowdRest::Session.find(login.token, :include => :user).user
  end
  
  it "has the expected attributes for a user" do
    @user.first_name.should == "Crowd"
    @user.last_name.should == "Test"
    @user.display_name.should == "Crowd Test"
    @user.email.should == "crowduser@test.com"
    @user.name.should == "crowduser"
  end
end
