require "spec_helper"

describe CrowdRest do
  context "given valid app credentials" do
    it "will not get an '401 Unauthorized' response" do
      # valid params are set in spec_helper
      response = CrowdRest.get("/search")
      response.code.should_not == 401
    end
  end

  context "given invalid app credentials" do
    before(:all) do
      @old_app_name = CrowdRest.app_name
      @old_app_pass = CrowdRest.app_pass
      CrowdRest.app_name = "badname"
      CrowdRest.app_pass = "badpass"
    end
    
    after(:all) do
      CrowdRest.app_name = @old_app_name
      CrowdRest.app_pass = @old_app_pass
    end
    
    it "will get an '401 Unauthorized' response" do
      response = CrowdRest.get("/search")
      response.code.should == 401      
    end
  end
end
