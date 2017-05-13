#!/usr/bin/env ruby
require 'sinatra'

get '/' do
  redirect to('/hello/World')
end

get '/hello/:name' do
  "Hello #{params[:name]}!"
end

