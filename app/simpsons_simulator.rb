#!/usr/bin/env ruby
require 'sinatra'
require 'json'

set :bind, '0.0.0.0'

def parse_gift(raw)
  parsed = JSON.parse(raw)
  parsed['gift']
end

get '/' do
  "Welcome to the Simpson household"
end

get '/homer' do
  "I hope you brought donuts"
end

post '/homer' do
  gift = parse_gift(request.body.read)
  if gift == 'donut'
    [200, 'Woohoo']
  else
    [400, "D'oh"]
  end
end

###################################
# FIXED: Implement Lisa endpoints #
###################################
get '/lisa' do
  "The baritone sax is the best sax"
end

post '/lisa' do
  gift = parse_gift(request.body.read)
  if gift == 'book'
    [200, 'I love it']
  elsif gift == 'saxaphone'
    [200, 'I REALLY love it']
  elsif gift == 'video_game'
    [400, "I hate it"]
  else
    [400, "I REALLY hate it"]
  end
end
