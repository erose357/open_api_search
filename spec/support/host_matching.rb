#include_http_adapter_for("faraday")

require 'vcr'

VCR.configure do |c|
  c.hook_into :webmock
  c.default_cassette_options = { :match_requests_on => [:host] }
  c.cassette_library_dir = 'spec/cassettes'
end
