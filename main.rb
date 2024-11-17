require 'sinatra'
require 'json'

set :port, 8000

Version = Struct.new(:version)

get '/version' do
  content_type :json
  Version.new('1.0.0').to_h.to_json
end

not_found do
  'Not Found'
end