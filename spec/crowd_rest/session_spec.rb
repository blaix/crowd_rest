require "spec_helper"

describe CrowdRest::Session do
  shared_examples "a failed request" do
    it "includes a failure reason in the response" do
      @response.reason.should_not be_nil
    end
    
    it "includes a failure message in the response" do
      @response.message.should_not be_nil
    end
  end    
  
  describe ".create" do
    context "given valid user credentials" do
      before(:all) do
        @response = CrowdRest::Session.create("crowduser", "crowdpass")
      end
      
      it "creates a new session" do
        @response.code.should == 201
      end

      it "includes the sso token in the response" do
        @response.token.should_not be_nil
      end
    end

    context "given invalid user credentials" do
      before(:all) do
        @response = CrowdRest::Session.create("baduser", "badpass")
      end

      it_behaves_like "a failed request"
      
      it "does not create a new session" do
        @response.code.should_not == 201
      end
    end
  end
  
  describe ".find(token)" do
    context "given a valid session token" do
      before(:all) do
        login = CrowdRest::Session.create("crowduser", "crowdpass")
        @response = CrowdRest::Session.find(login.token)
      end
      
      it "responds successfuly" do
        @response.code.should == 200
      end
    end
    
    context "given an invalid session token" do
      before(:all) do
        @response = CrowdRest::Session.find("beefface")
      end
      
      it_behaves_like "a failed request"

      it "does not respond successfuly" do
        @response.code.should_not == 200
      end
    end
  end
  
  describe ".find(token, :include => :user)" do
    before(:all) do
      login = CrowdRest::Session.create("crowduser", "crowdpass")
      @response = CrowdRest::Session.find(login.token, :include => :user)
    end
    
    it "includes the user in the response" do
      @response.user.should_not be_nil
      @response.user['name'].should == "crowduser"
    end
  end
end
