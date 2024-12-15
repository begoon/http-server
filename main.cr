require "http/server"
require "json"

class Version
  include JSON::Serializable
  @version : String = "1.0.0"

  def initialize
  end
end

server = HTTP::Server.new do |context|
  if context.request.path == "/version"
    payload = context.response.content_type = "application/json"
    context.response.print(Version.new.to_json)
  else
    context.response.status_code = 404
    context.response.print("Not Found")
  end
end

address = server.bind_tcp 8000
puts "listening unning on #{address}"
server.listen
