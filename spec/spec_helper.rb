require "rubygems"
require "bundler/setup"

require "rspec"
RSpec.configure do |config|
  config.fail_fast = true
end

require "crowd_rest"
CrowdRest.crowd_url = "http://127.0.0.1:8095"
CrowdRest.app_name = "demo"
CrowdRest.app_pass = "demo_pass"
