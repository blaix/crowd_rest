require "rubygems"
require "bundler/setup"

require "rspec"
require "vcr"

require "crowd_rest"

CrowdRest.config do |c|
  c.crowd_url = "http://127.0.0.1:8095"
  c.app_name = "demo"
  c.app_pass = "demo_pass"
end

VCR.config do |c|
  c.cassette_library_dir = File.expand_path("cassette_library", File.dirname(__FILE__))
  c.stub_with :fakeweb
  c.ignore_localhost = false
end

if ENV['DONT_FAKE']
  puts "VCR: Will record all http requests made during this test run..."
  record_type = :all
  at_exit { VCR.eject_cassette }
else
  puts "VCR: Using previously recorded http requests. " +
       "Run with DONT_FAKE=1 to hit the web and record new requests."
  record_type = :none
end

VCR.insert_cassette('test_data', :record => record_type)

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros
end
