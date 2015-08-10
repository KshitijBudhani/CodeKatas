require "net/http"
require "uri"
require 'openssl'
require 'json'

o_auth_token = '6478e1e90b7c64fb79e2737df613c63c7d735fad'
uri = URI.parse("https://api.github.com/users/matrangam/orgs?access_token=#{o_auth_token}")

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

# 6478e1e90b7c64fb79e2737df613c63c7d735fad
request = Net::HTTP::Get.new(uri.request_uri)
# eq.basic_auth 'user', 'pass'
response = http.request(request)
puts response.body

# -- Build an application, that given a git username:
#   -- return a list of that user’s repositories:
#   -- repo name
#   -- days since last push
#   -- contributors
#   -- git user name
