local socket = require("socket")
local copas = require("copas")
local json = require("dkjson")

local version_info = { version = "1.0.0" }

local function handle_request(client)
    client = copas.wrap(client)
    local request = client:receive("*l")

    if request then
        -- Parse the request line (e.g., "GET /version HTTP/1.1")
        local method, path = request:match("^(%w+)%s(/%S*)%sHTTP/%d.%d")

        if method == "GET" and path == "/version" then
            local response_body = json.encode(version_info, { indent = false })
            local response = "HTTP/1.1 200 OK\r\n" ..
                "Content-Type: application/json\r\n" ..
                "Content-Length: " .. #response_body .. "\r\n" ..
                "Connection: close\r\n\r\n" ..
                response_body
            client:send(response)
        else
            local response = "HTTP/1.1 404 Not Found\r\n" ..
                "Content-Type: text/plain\r\n" ..
                "Content-Length: 13\r\n" ..
                "Connection: close\r\n\r\n" ..
                "404 Not Found"
            client:send(response)
        end
    end

    client:close()
end

local server = assert(socket.bind("*", 8000))
print("listening on http://localhost:8000")

copas.addserver(server, handle_request)

copas.loop()
