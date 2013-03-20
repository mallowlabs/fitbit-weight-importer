#! /user/bin/env ruby
# -*- mode:ruby; coding:utf-8 -*-

# original source from http://www.fitbitclient.com/guide/using-fitgem

require "fitgem"
require "pp"
require "yaml"
begin
  require "fastercsv"
rescue LoadError
  require "csv"
  FCSV = CSV
end

unless ARGV.first
  warn "Usage: bundle exec ruby bin/main.rb graph.csv"
  exit -1
end

# Load the existing yml config
config = begin
  Fitgem::Client.symbolize_keys(YAML.load(File.open("config/fitgem.yml")))
rescue ArgumentError => e
  puts "Could not parse YAML: #{e.message}"
  exit
end

client = Fitgem::Client.new(config[:oauth])

# With the token and secret, we will try to use them
# to reconstitute a usable Fitgem::Client
if config[:oauth][:token] && config[:oauth][:secret]
  begin
    access_token = client.reconnect(config[:oauth][:token], config[:oauth][:secret])
  rescue Exception => e
    puts "Error: Could not reconnect Fitgem::Client due to invalid keys in .fitgem.yml"
    exit
  end
# Without the secret and token, initialize the Fitgem::Client
# and send the user to login and get a verifier token
else
  request_token = client.request_token
  token = request_token.token
  secret = request_token.secret

  puts "Go to http://www.fitbit.com/oauth/authorize?oauth_token=#{token} and then enter the verifier code below"
  verifier = gets.chomp

  begin
    access_token = client.authorize(token, secret, { :oauth_verifier => verifier })
  rescue Exception => e
    puts "Error: Could not authorize Fitgem::Client with supplied oauth verifier"
    exit
  end

  puts 'Verifier is: '+verifier
  puts "Token is:    "+access_token.token
  puts "Secret is:   "+access_token.secret

  user_id = client.user_info['user']['encodedId']
  puts "Current User is: "+user_id

  config[:oauth].merge!(:token => access_token.token, :secret => access_token.secret, :user_id => user_id)

  # Write the whole oauth token set back to the config file
  File.open("config/fitgem.yml", "w") {|f| f.write(config.to_yaml) }
end

# ============================================================
# Add Fitgem API calls on the client object below this line

#pp client.activities_on_date 'today'
client.api_unit_system = Fitgem::ApiUnitSystem.METRIC

FCSV.foreach(ARGV.first, :headers => true) do |row|
  date, weight, fat = row.fields
  hash = {:date => date}
  hash[:weight] = weight unless weight.empty?
  hash[:fat] = fat unless fat.empty?

  pp client.log_body_measurements(hash) if hash.keys.size > 1
  sleep 1
end


