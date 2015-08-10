require "net/http"
require "uri"
require 'openssl'
require 'json'
load 'repo.rb'

o_auth_token = '6478e1e90b7c64fb79e2737df613c63c7d735fad'
authentication = "access_token=#{o_auth_token}"
username = "matrangam" #XXX: To come from the argzzzzzzzz
repos_url = "https://api.github.com/users/#{username}/repos"

uri = URI.parse("#{repos_url}?#{authentication}")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(uri.request_uri)
response = http.request(request)
json_response = JSON.parse(response.body)

repos = []
json_response.each do |repo|
  repos << Repo.new(repo)
end

repos.each { |r| puts r.name, r.last_push, "\n" }

# -- Build an application, that given a git username:
#   -- return a list of that user’s repositories:
#   -- repo name
#   -- days since last push
#   -- contributors
#   -- git user name
