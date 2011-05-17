require "spec_helper"

describe CrowdRest::Session do
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
      
      it "does not create a new session" do
        @response.code.should_not == 201
      end
      
      it "is a bad request" do
       @response.code.should == 400
      end
      
      it "includes a failure reason in the response" do
        @response.reason.should_not be_nil
      end
      
      it "includes a failure message in the response" do
        @response.message.should_not be_nil
      end
    end
  end
end
